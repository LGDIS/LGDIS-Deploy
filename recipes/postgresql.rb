namespace :postgresql do

  desc "install postgresql"
  task :install, :roles => [:dbroot] do
    run "yum remove -y postgresql*"
    #run "rpm -ivh http://yum.postgresql.org/9.2/redhat/rhel-6-x86_64/pgdg-centos92-9.2-6.noarch.rpm"
    run "yum install -y postgresql92*"
    run "yum install -y postgis2_92-devel.x86_64"
    #run "mv /etc/my.cnf{,.#{Time.now.strftime('%Y%m%d%H%M%S')}}"
    #run "cp /usr/share/mysql/my-large.cnf /etc/my.cnf"
    #start
    setupuser

  end

  task :start, :roles => [:db] do
    #run "/etc/init.d/pgsql start"
    run "echo start"
  end

  task :stop, :roles => [:db] do
    #run "/etc/init.d/mysqld stop"
    run "echo stop"
  end

  task :restart, :roles => [:db] do
    #run "/etc/init.d/mysqld restart"
    run "echo restart"
  end

  desc "uninstall postgres"
  task :uninstall, :roles => [:dbroot] do
     run "yum remove -y  postgresql*"
     run "userdel postgres"
  end

  desc "setup user postgres"
  task :setupuser, :roles => [:dbroot] do
    #home_dir = "/var/lib/pgsql"
    ssh_dir = "~/.ssh"
    upload "#{CapExample::local_dir}/keys/id_rsa.pub", "/tmp/id_rsa.pub"
    run "mkdir -p #{ssh_dir}"
    run "chmod 700 #{ssh_dir}"
    run "cat /tmp/id_rsa.pub >> #{ssh_dir}/authorized_keys"
    run "chmod 600 #{ssh_dir}/authorized_keys"
    run "rm -f /tmp/id_rsa.pub"
    run "chown -R #{db_user}:#{db_user} #{ssh_dir}"
  end


end
