source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.7'

# Use sqlite3 for development
group :development do
  gem 'sqlite3'
end

# Use SCSS for stylesheets
gem 'sass-rails'
# Automatically add browser specific css prefixes
gem 'autoprefixer-rails'
# Use Twitter Boostrap CSS framework
gem 'twitter-bootstrap-rails', github: 'seyhunak/twitter-bootstrap-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Better form helpers
gem 'simple_form'
# Use Haml for views
gem 'haml'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails', github: 'joliss/jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jquery-turbolinks', github: 'kossnocorp/jquery.turbolinks'
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]

# Administrate the site from a separate frontend interface
gem 'formtastic', github: 'justinfrench/formtastic'
gem 'activeadmin', github: 'activeadmin'

# Generate fake data for seeding
gem 'faker'

# User Authentication
gem 'devise'
# Pagination
gem 'kaminari'
# Voting
gem 'acts_as_votable', '~> 0.10.0'
# Commenting
gem 'awesome_nested_set'
gem 'acts_as_commentable_with_threading'

group :development do
  gem "better_errors"
end

group :production do
  # Rails Heroku integration
  gem 'rails_serve_static_assets'
  gem 'rails_12factor', group: :production
  # Use postgresql for production
  gem 'pg'
  # use puma app server
  gem 'puma'
end
