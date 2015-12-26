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
      :fenced_code_blocks           => true,
      :no_intra_emphasis            => true,
      :tables                       => true,
      :autolink                     => true,
      :disable_indented_code_blocks => true,
      :quote                        => true,
      :lax_spacing                  => true
    })

    # Render all of our custom markdown elements
    rendered_doc = custom_content_card(document, r)
  end

  def custom_content_card(document, renderer)
    document.gsub(/^\[\[(.*?)\n(.*?)\n([^\n]*?)\]\]/m) do
      resp = "<div class=\"panel panel-default\">
        <div class=\"panel-heading\">
          <div class=\"panel-title\">
          #{$1}
          </div>
        </div>
        <div class=\"panel-body\">#{renderer.render($2)}</div>
        <div class=\"panel-footer\">#{$3}</div>
      </div>"
      resp
    end
  end

end
