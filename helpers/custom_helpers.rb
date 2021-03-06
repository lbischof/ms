module CustomHelpers
    def get_current_page
        if current_page.url == '/'
            "index"
        else
            current_page.url.gsub('/','')
        end
    end

    def sanitize string
        string.downcase.gsub(/[^0-9a-z](\(.*?\))?/, '')
    end

    def colour_image_tag(product, colour)
        image_tag("#{get_current_page}/#{sanitize product}/#{sanitize colour}.jpg", { alt: colour })
    end

    def banner_image_tag product
        "<div class=\"banner banner-#{sanitize product}\"></div>"
    end

    def includepartial pdata
        partial "#{pdata.partial}", locals: { pdata: pdata }
    end

    def markdown text
        Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text)
    end

    def nav_link(link_text, url, options = {})
        options[:class] ||= ""
        options[:class] << " active" if url == "/#{current_page.path}"
        link_to(link_text, url, options)
    end
end
