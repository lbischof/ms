###
# Page options, layouts, aliases and proxies
###

set :url_root, 'https://lorenz.io/maplesplendor.ca'
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
data.pages.each do |page, page_data|
     proxy_page = (page == 'index') ? 'index.html' : "/#{page}/index.html"
     proxy proxy_page, "/page.html", :layout => page_data[0].layout || 'layout', :locals => { page: page, page_data: page_data }, :ignore => true
end

activate :automatic_image_sizes
set :relative_links, true
activate :relative_assets
activate :directory_indexes

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end

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
