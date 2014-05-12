module ProductsHelper
  def product_name(product)
    if product.respond_to?("highlight") && product.highlight.respond_to?("name")
      link_to product.highlight.name[0].html_safe, product_path(product._id)
    else
      link_to product.name, product_path(product._id)
    end
  end

  def product_description(product)
    if product.respond_to?("highlight") && product.highlight.respond_to?("description")
      link_to product.highlight.description[0].html_safe, product_path(product._id)
    else
      link_to product.description, product_path(product._id)
    end
  end
end
