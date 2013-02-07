namespace :unicorn do

  desc "setup unicorn"
  task :setup, :roles => [:web] do
    rconfig_path = "#{deploy_to}/shared/config/"
    run "mkdir -p #{rconfig_path}"
    erb_path = "#{CapExample::local_dir}/templates/unicorn/unicorn.conf.erb"
    put (ERB.new(File.read(erb_path))).result(binding), "#{rconfig_path}/unicorn.conf"
    run "chown -R #{rails_user}.#{rails_user} #{rconfig_path}"

    erb_path = "#{CapExample::local_dir}/templates/unicorn/unicorn.init.erb"
    put (ERB.new(File.read(erb_path))).result(binding), "/tmp/unicorn.init"
    run "mv /tmp/unicorn.init /etc/init.d/unicorn"
    run "chmod 755 /etc/init.d/unicorn"

    run "chkconfig --add unicorn"
    run "chkconfig --level 2345 unicorn on"
    start
  end

  desc "start unicorn"
  task :start, :roles => [:web] do
    run "/etc/init.d/unicorn start"
    run "chown rails. #{current_path}/log/unicorn.#{unicorn_port}.log"
  end

  desc "stop unicorn"
  task :stop, :roles => [:web] do
    run "/etc/init.d/unicorn stop"
  end

end
