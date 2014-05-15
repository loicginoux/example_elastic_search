require 'elasticsearch/model'

class Product < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  attr_accessor :new_brand_name
  
  belongs_to :brand
  
  before_save :create_brand_from_name

  
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "150x150>" }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :description, presence: true
  validates :photo, presence: true

  paginates_per 5

  TYPE = ["camera", "car"]

  after_commit :index_doc, on: :create

  after_commit :update_doc, on: :update

  after_commit :delete_doc, on: :destroy

  after_touch  :update_doc

  def index_doc
    __elasticsearch__.index_document
  end
  def update_doc
    __elasticsearch__.update_document
  end
  def delete_doc
    __elasticsearch__.delete_document
  end

  def typed_as
    index = prod_type - 1
    TYPE[index]
  end

  def create_brand_from_name
    Brand.create!(:name => new_brand_name) unless new_brand_name.blank?
  end

  def as_indexed_json(options={})
    self.as_json( methods: [:typed_as],
      include: { 
        brand: { only: [:name, :country]}
      }
      )
  end


  def self.search(params)
    params[:page] ||= 1
    # Prefill and set the filters (top-level `filter` and `facet_filter` elements)
    #
    __set_filters = lambda do |key, f|

      @search_definition[:filter][:and] ||= []
      @search_definition[:filter][:and]  |= [f]

      @search_definition[:facets][key.to_sym][:facet_filter][:and] ||= []
      @search_definition[:facets][key.to_sym][:facet_filter][:and]  |= [f]

      if @search_definition[:query][:match_all]
        @search_definition[:query] = { :bool =>  {}}
      end
      @search_definition[:query][:bool][:must] ||= []
      @search_definition[:query][:bool][:must].push f
    end


    @search_definition = {}
    facets = {
      type:{
        terms: { field: "typed_as"},
        facet_filter: {}
        },
        origin_country: {
          terms: { field: "brand.country"},
          facet_filter: {}
          },
          brand:{
            terms: { field: "brand.name"},
            facet_filter: {}
            },
          }
          @search_definition[:facets] = facets
          @search_definition[:query] = { match_all: {}}
          @search_definition[:filter] = {}

          if params[:search] && params[:search] != ""
      # Product.__elasticsearch__.search(params[:search]).records.to_a
      @search_definition[:query] = {
        bool: {
          should: [
            { 
              multi_match:  { 
                query: params[:search],
                fields: ["name^10", "description^2"],
                operator: 'and'
              } 
            }
          ]
        }
        
      }
      @search_definition[:highlight] = { 
        fields: { 
          name: {},
          description: {}
        } 
      }
    end

    if params[:brand]
      f = { term: { 'brand.name' => params[:brand] } }
      __set_filters.(:brand, f)
    end

    if params[:origin_country]
      f = { term: { 'brand.country' => params[:origin_country] } }
      __set_filters.(:origin_country, f)
    end

    if params[:type]
      f = { term: { 'typed_as' => params[:type] } }
      __set_filters.(:type, f)
    end

    unless params[:search].blank?
      @search_definition[:suggest] = {
        text: params[:search],
        suggest_name: {
          term: {
            field: 'name.tokenized',
            suggest_mode: 'always'
          }
          },
          suggest_description: {
            term: {
              field: 'description.tokenized',
              suggest_mode: 'always'
            }
          }
        }
      end

      __elasticsearch__.search(@search_definition).page(params[:page])
    end
  end
