set :application, "LGDIS"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm, :git
#set :repository, "#{CapExample::local_dir}/files/example"
set :repository, "git://github.com/LGDIS/LGDIS.git"
set :branch, "master"

set :deploy_via, :copy
set :deploy_to, "/home/rails/#{application}"
set :copy_remote_dir, deploy_to
set :use_sudo, false 
#set :use_sudo, true 
set :root_user, "root"
set :p_user, "nttpc"
set :rails_user, "rails"
set :db_user, "postgres"
set :normalize_asset_timestamps, false
#set :bundle_flags, "--deployment --quiet --local"
set :bundle_flags, "--deployment --local"
ssh_options[:keys] = %w(./keys/id_rsa)
default_run_options[:pty]=true

