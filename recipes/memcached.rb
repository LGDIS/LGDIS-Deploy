# -*- coding: utf-8 -*-
namespace :memcached do 
  
  desc "install memcached"
  task :install, :roles => :root do

    memcached_conf = "memcached"
    run "yum install -y memcached"
    run "mv /etc/sysconfig/memcached{,.#{Time.now.strftime('%Y%m%d%H%M%S')}}"
    upload "#{CapExample::local_dir}/files/ruby/#{memcached_conf}", "#{memcached_conf}"
    run "cp -p ./#{memcached_conf} /etc/sysconfig/#{memcached_conf}"
    run "rm -rf ./#{memcached_conf}"
    #run "cp /usr/share/mysql/my-large.cnf /etc/my.cnf"
    #start
  end
  task :start, :roles => [:root] do
    #run "/etc/init.d/memcached  start"
    run "echo start"
  end
  
  task :stop, :roles => [:root] do
    # run "/etc/init.d/memcached  stop"
    run "echo stop"
  end

  task :restart, :roles => [:root] do
    # run "/etc/init.d/memcached  restart"
    run "echo restart"
  end

  desc "setup memcached"
  task :conf, :roles => [:root] do
    run "chkconfig --level 2345 memcached on"
  end



end
