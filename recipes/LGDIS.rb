namespace :LGDIS do
  

  desc "install application"
  task :install do
    setup.rails_user
    iptables.setup
    ntp.install
    ruby.install
    postgresql.install
    postgresql.setupuser
    deploy.setup
    deploy.update
    setup.db
    deploy.migrate
    unicorn.setup
    nginx.install
  end

  namespace :setup do

    desc "setup user rails"
    task :rails_user, :roles => [:root] do
      #home_dir = "/var/#{rails_user}"
      home_dir = "/home/#{rails_user}"
      ssh_dir = "#{home_dir}/.ssh"
      id = "1002"

      run "useradd -u #{id} -d #{home_dir} rails"
      upload "#{CapExample::local_dir}/keys/id_rsa.pub", "/tmp/id_rsa.pub"
      run "mkdir -p #{ssh_dir}"
      run "chmod 700 #{ssh_dir}"
      run "cat /tmp/id_rsa.pub >> #{ssh_dir}/authorized_keys"
      run "chmod 600 #{ssh_dir}/authorized_keys"
      run "rm -f /tmp/id_rsa.pub"
      run "chown -R #{rails_user}:#{rails_user} #{ssh_dir}"
    end

    desc "setup db"
    task :db, :roles => [:app] do
      upload "#{CapExample::local_dir}/files/application/database.yml", "#{current_path}/config/database.yml"
      run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake db:create"
    end

    desc "LGDIS test"
    task :checkit, :roles => [:app] do
      run "echo #{rails_user}"
      run "echo #{application}"
      #run "echo #{roles}"
    end
  end
end
