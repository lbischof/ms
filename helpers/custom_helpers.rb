module CustomHelpers
    def mals_multiple product
        begin
            partial "partials/mals_multiple", locals: { product: product }
        rescue Exception => msg
            puts "Error in CustomHelpers."
            puts "Page: #{current_page.path} Product: #{product}"
            puts msg
            raise
        end
    end
    def current_page_data product
        begin
            data.public_send(current_page.path.split('.')[0]).public_send(product)
        rescue Exception => msg
            puts "Error in CustomHelpers."
            puts "Page: #{current_page.path} Product: #{product}"
            puts msg
            raise
        end
    end
    def product_image_tag product, colour
        image_tag "/images/#{current_page.path.split('.')[0]}/#{product}/#{colour.downcase.gsub(/[^0-9a-z]/, '')}.jpg"
    end
end
