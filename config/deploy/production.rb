## for production 
set :rails_env, 'production'

role :app, "210.150.7.185", :user => rails_user
role :proxy, "192.168.1.10", :no_release => true
role :web, "192.168.1.10", :no_release => true
role :db, "192.168.1.10", {:primary => true, :no_release => true}

set :ntp_server, "ntp.jst.mfeed.ad.jp"
set :unicorn_port, 3100
set :unicorn_pid_dir, "tmp/pids"
set :unicorn_log_dir, "log"

set :user, "deploy_user for production"
set (:password) do
  Capistrano::CLI.password_prompt "Set password for #{rails_env} server: "
end
