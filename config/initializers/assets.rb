puts "-"*20


puts "-"*20
# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.scss, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
# Rails.application.config.assets.precompile << %r(bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff2?)$)
puts "-"*20

Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'components')
puts "-"*20

Rails.application.config.assets.precompile << %r(bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff2?)$)
puts "-"*20

Rails.application.config.assets.precompile << 'bootstrap-sass/assets/javascripts/bootstrap-sprockets.js'
puts "-"*20
