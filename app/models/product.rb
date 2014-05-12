require 'elasticsearch/model'

class Product < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "150x150>" }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :description, presence: true
  validates :photo, presence: true

  paginates_per 5



  def self.search(params)
    params[:page] ||= 1
    if params[:search] && params[:search] != ""
      # Product.__elasticsearch__.search(params[:search]).records.to_a
      Product.__elasticsearch__.search(
        query: { 
          multi_match:  { 
            query: params[:search],
            fields: ["name", "description"]
          } 
        }, 
        highlight: { 
          fields: { 
            name: {},
            description: {}
          } 
        }
      ).page(params[:page])
    else
      Product.__elasticsearch__.search(
        query: {
          match_all: {}
        }
      ).page(params[:page])
    end
  end
end
