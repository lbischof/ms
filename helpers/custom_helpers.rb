module CustomHelpers
    def mals_multiple product
        begin
            partial "system/partials/mals_multiple", locals: { product: product }
        rescue Exception => msg
            puts "Error in helpers: mals_multiple"
            puts "Page: #{current_page.path} Product: #{product}"
            puts msg
            raise
        end
    end
    def current_page_data product
        begin
            data[current_page.path.split('.')[0]][product]
        rescue Exception => msg
            puts "Data doesn't exist"
            puts "Page: #{current_page.path.split('.')} Product: #{product}"
            raise
        end
    end
    def product_image_tag product, colour
        image_tag "#{current_page.path.split('.')[0]}/#{colour.downcase.gsub(/[^0-9a-z]/, '')}.jpg"
    end
end
