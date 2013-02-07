namespace :yum do

  desc "setup  yum"
  task :setup, :roles => [:root] do
    upload "#{CapExample::local_dir}/files/yum/yum.conf", "/tmp/yum.conf"
    run "mv /etc/yum.conf{,.#{Time.now.strftime('%Y%m%d%H%M%S')}}"
    run "cp -p /tmp/yum.conf /etc/yum.conf"
    run "rm -f /tmp/yum.conf"
    #
    upload "#{CapExample::local_dir}/files/yum/local.repo", "/tmp/local.repo"
    run "mkdir -p /etc/yum.repos.d/bak/"
    run "mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak/"
    run "cp -p /tmp/local.repo /etc/yum.repos.d/local.repo"
    run "rm -f /tmp/local.repo"

  end
end
