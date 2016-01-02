module CustomHelpers
    def product_image_tag colour
        image_tag "#{current_page.path.split('.')[0]}/#{colour.downcase.gsub(/[^0-9a-z]/, '')}.jpg"
    end

    def includepartial(partial, page, key)
        partial "#{partial}", locals: { pdata: data['pages'][page][key] }
    end
end
