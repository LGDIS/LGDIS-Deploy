namespace :mysql do

  desc "install mysql"
  task :install, :roles => [:db] do
    run "yum install -y mysql-server"
    run "mv /etc/my.cnf{,.#{Time.now.strftime('%Y%m%d%H%M%S')}}"
    run "cp /usr/share/mysql/my-large.cnf /etc/my.cnf"
    start
  end

  task :start, :roles => [:db] do
    run "/etc/init.d/mysqld start"
  end

  task :stop, :roles => [:db] do
    run "/etc/init.d/mysqld stop"
  end

  task :restart, :roles => [:db] do
    run "/etc/init.d/mysqld restart"
  end

end
