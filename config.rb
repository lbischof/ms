###
# Page options, layouts, aliases and proxies
###

# Ignore layouts and partials dir from build
ignore 'system/layouts/*'
ignore 'system/partials/*'
set :css_dir, 'system/css'
set :js_dir, 'system/js'
set :layouts_dir, 'system/layouts'

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

ignore 'product.html.erb'
data.products.each do |page, page_data|
     proxy "/#{page}/index.html", "/product.html", :layout => page_data['layout'] || 'layout', :locals => { page: page }, :ignore => true
end
proxy "/index.html", "/product.html", :layout => 'layout', :locals => { page: 'index' }, :ignore => true


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
