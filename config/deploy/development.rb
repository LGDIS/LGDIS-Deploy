deplpy/development.rb

set :rails_env, 'development'

role :web, "210.150.7.185" :user => nginx
role :app, "210.150.7.185"
role :db,  "210.150.7.186", :primary => true

set :deploy_to, '/var/www/capistrano_sample/development/' 


