class CustomMarkdown < Redcarpet::Render::HTML
    def initialize(options={})
        super options.merge(
            :with_toc_data                => true,
        )
    end

    def preprocess(document)

        # We need this renderer to force render of content within our multi-line markdown elements
        # Note this is the same config used in config.rb for the generic middleman renderer
        r = Redcarpet::Markdown.new(self, options = {
            :markdown => true,
            :autolink                     => true,
            :lax_spacing                  => true
        })
        # Render all of our custom markdown elements
        rendered_doc = mals_item(document, r)
        rendered_doc = mals_form(rendered_doc, r)
        rendered_doc = mals_radio(rendered_doc, r)
        rendered_doc = mals_cart(rendered_doc, r)
    end

    def mals_form(document, r)
        document.gsub(/!!form/) do
            resp = <<-HTML
<form action="http://ww8.aitsafe.com/cf/addmulti.cfm" method="post">
    <input type="hidden" name="userid" value="A4132041">
    <input type="hidden" name="return" value="www.maplesplendor.ca/dollsandsupplies.htm">
            HTML
            resp
        end
    end

    def mals_cart(document, r)
        document.gsub(/^!!cart(?: (.*) ([0-9]+))?$/) do
            resp = <<-HTML
    #{"<input type=\"hidden\" name=\"price\" value=\"#{$2}\">" if $2}
    #{"<input type=\"hidden\" name=\"product\" value=\"#{$1}\">" if $1}
</form>
            HTML
            resp
        end
    end

    def mals_item(document, r)
        document.gsub(/^!!item (.*) (\w+)?/) do
            resp = <<-HTML
    <div class="item">#{$1}</div>
            HTML
            resp
        end
    end

    def mals_radio(document, r)
        document.gsub(/^!!radio (.*) ([0-9]+)$/) do
            resp = <<-HTML
    <input name="productpr1" type="radio" value="#{$1}:#{$2}">#{$1} #{$2}</input>
            HTML
            resp
        end
    end
end
