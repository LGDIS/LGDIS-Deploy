namespace :nginx do

  desc "install nginx"
  task :install, :roles => :root do
    run "service httpd stop"
    run "yum -y remove httpd*"
    rpm = "nginx-1.2.6-1.el6.ngx.x86_64.rpm"
    upload "#{CapExample::local_dir}/files/nginx/#{rpm}", rpm
    run "yum -y localinstall #{rpm}"
    run "rm -f #{rpm}"

    run "mv /etc/nginx/conf.d/default.conf{,.#{Time.now.strftime('%Y%m%d%H%M%S')}}"
    erb_path = "#{CapExample::local_dir}/templates/nginx/default.conf.erb"
    put (ERB.new(File.read(erb_path))).result(binding), "/etc/nginx/conf.d/default.conf"
    start
  end

  task :start, :roles => :web do
    run "/etc/init.d/nginx start"
  end

  task :stop, :roles => :web do
    run "/etc/init.d/nginx stop"
  end

  task :restart, :roles => :web do
    run "/etc/init.d/nginx restart"
  end

end
