# Load the Rails application.
require File.expand_path('../application', __FILE__)






ActionController::Base.relative_url_root = "/"
ENV['RAILS_RELATIVE_URL_ROOT']  = "/"
ENV['ROOT_URL']  = "/"


# Initialize the Rails application.
Rails.application.initialize!
ENV['RAILS_ENV'] ||= 'development'
#Rails.env = "production"
