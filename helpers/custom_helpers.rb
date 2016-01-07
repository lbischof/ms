module CustomHelpers
    def colour_image_tag colour
        image_tag "#{current_page.path.split('.')[0]}/#{colour.downcase.gsub(/[^0-9a-z](\(.*\))?/, '')}.jpg"
    end

    def banner_image_tag product
        "<div class=\"banner\" style=\"background-image: url('images/#{current_page.path.split('.')[0]}/banner-#{product.downcase}.jpg')\"></div>"
    end

    def includepartial pdata
        partial "#{pdata.partial}", locals: { pdata: pdata }
    end

    def markdown text
        Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text)
    end
end
