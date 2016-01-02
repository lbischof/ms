module CustomHelpers
    def product_image_tag product, colour
        image_tag "#{current_page.path.split('.')[0]}/#{colour.downcase.gsub(/[^0-9a-z]/, '')}.jpg"
    end

    def includepartial(partial, page, key)
        partial "system/partials/#{partial}", locals: { pdata: data['products'][page][key] }
    end
end
