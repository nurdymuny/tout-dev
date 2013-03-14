# encoding: UTF-8
# Libraries::::::::::::::::::::::::::::::::::::::::::::::::::::::::
require 'sinatra/base'
require 'sinatra/flash'
require 'rack/csrf'
require 'sprockets'
require 'haml'
require 'sass'
require 'coffee-script'
require 'compass'
require 'padrino-helpers'
require 'sinatra/partial'
require './app/helpers/app_helpers'

# Application::::::::::::::::::::::::::::::::::::::::::::::::::::::
class Application < Sinatra::Base

  include Sinatra::AssetHelpers

  register Sinatra::Flash
  register Padrino::Helpers
  register Sinatra::Partial

  # Config::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  set :partial_template_engine, :haml
  enable :partial_underscores
  set :static, true
  set :root, File.dirname(__FILE__)
  set :sprockets, (Sprockets::Environment.new(root) { |env| env.logger = Logger.new(STDOUT) })
  set :assets_prefix, 'compiled'
  set :assets_path, File.join(root, 'public', assets_prefix)
  set :compass_gem_root, Gem.loaded_specs['compass'].full_gem_path
  set :views, Proc.new { File.join(root, 'app', 'views') }

  configure do
    sprockets.append_path File.join(root, 'app', 'assets', 'stylesheets')
    sprockets.append_path File.join(compass_gem_root, 'frameworks', 'compass', 'stylesheets')
    sprockets.append_path File.join(root, 'app', 'assets', 'javascripts')
    sprockets.append_path File.join(root, 'app', 'assets', 'images')
  end


  # we are deploying to heroku, which does not have a JVM, which YUI needs, so let's
  # only require and config the compressors / minifiers for dev env
  configure :development do
    require 'yui/compressor'
    require 'uglifier'
    sprockets.css_compressor = YUI::CssCompressor.new
    sprockets.js_compressor  = Uglifier.new(mangle: true)
  end

  # Route Handlers::::::::::::::::::::::::::::::::::::::::::::::::
  # index
  get ('/') { haml :index, layout:false }

  # account
  get '/profile' do
    "Hello World" 
    haml :'users/_profile'
  end

  # assets
  get '/assets/application.js' do
    content_type('application/javascript')
    settings.sprockets['application.js']
  end

  get '/assets/application.css' do
    content_type('text/css')
    settings.sprockets['application.css']
  end

  %w{jpg jpeg gif png}.each do |format|
    get '/assets/:image.' + format do |image|
      content_type('image/' + format)
      settings.sprockets[image + '.' + format]
    end
  end

end


__END__



