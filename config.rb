###
# Page options, layouts, aliases and proxies
###

set :url_root, 'http://maplesplendor.ca'
# Set markdown options
set :markdown_engine, :redcarpet
set(
  :markdown,
  :fenced_code_blocks           => true,
  :no_intra_emphasis            => true,
  :tables                       => true,
  :autolink                     => true,
  :disable_indented_code_blocks => true,
  :quote                        => true,
  :lax_spacing                  => true
)

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

ignore 'page.html.erb'
data.pages.each do |page,data|
     proxy_page = (page == 'index') ? 'index.html' : "/#{page}/index.html"
     proxy proxy_page, "/page.html", :layout => 'layout', :locals => { page: data }, :ignore => true
end

activate :automatic_image_sizes
set :relative_links, true
activate :relative_assets
activate :asset_hash
activate :directory_indexes
page "404.html", :directory_index => false
page "google9818175e4e03fea8.html", :directory_index => false

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :minify_html
  activate :gzip
end

#after_build do |builder|
#    rootPath = app.root
#      buildDir = app.config[:build_dir]
#      htmlDir = buildDir + File::SEPARATOR + '**' + File::SEPARATOR + '*.html'
#      Dir.glob(htmlDir) do |file|
#        assetPath = rootPath + File::SEPARATOR + file
#        file.slice! buildDir + File::SEPARATOR
#        %x(node_modules/.bin/critical #{assetPath} --base #{buildDir} --htmlTarget #{file} --minify --inline)
#      end
#end

# Deploy the static files
activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.branch = 'gh-pages' # or master

  committer_app = "#{Middleman::Deploy::PACKAGE} v#{Middleman::Deploy::VERSION}"
  commit_message = "Deployed using #{committer_app}"

  if ENV["TRAVIS_BUILD_NUMBER"] then
    commit_message += " (Travis Build \##{ENV["TRAVIS_BUILD_NUMBER"]})"
  end

  deploy.commit_message = commit_message
end
