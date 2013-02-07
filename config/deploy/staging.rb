
set :rails_env, 'stageing'

set :webserver, ["210.150.7.185"]
set :appserver, ["210.150.7.185"]
set :db_server, ["210.150.7.185"]

role :app, "210.150.7.185", :user => rails_user
role :root, "210.150.7.185", { :user => root_user, :no_release => true}
role :db, "210.150.7.185", {:primary => true, :no_release => true}
role :dbroot, "210.150.7.185", {:user => root_user, :no_release => true}

set :proxy_server, "203.138.187.103"
set :proxy_port, "8080"
set :ntp_server, "ntp.jst.mfeed.ad.jp"
set :unicorn_port, 3100
set :unicorn_pid_dir, "tmp/pids"
set :unicorn_log_dir, "log"
#set :bundle_flags, "--deployment --quiet"
set :bundle_flags, " --quiet"
set :app_path, " --quiet"
set :bundle_cmd, "/usr/local/ruby/bin/bundle"


before "bundle:install", :roles => :app do
  pg_opts = "--with-pg-dir=/usr/pgsql-9.2"
  run "env"
  run "echo #{fetch(:latest_release, "pg")}"
  run "cd #{latest_release} ; #{bundle_cmd} config build.pg #{pg_opts}"
end

desc "Install RMagick"
task :install_rmagick, :roles => :root do
  sudo "yum install ImageMagick -y"
  sudo "yum install ImageMagick-devel -y"
end

task :before_migrate, :roles => :root do
  install_rmagick
end

task :chk , :roles => :app do
  run "echo #{:webserver}"
end

