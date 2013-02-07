namespace :ntp do

  desc "install ntp"
  task :install, :roles => [:proxy] do
    run "yum -y install ntp"

    erb_path = "#{CapExample::local_dir}/templates/ntp/ntp.conf.erb"
    run "mv /etc/ntp.conf{,.#{Time.now.strftime('%Y%m%d%H%M%S')}}"
    put (ERB.new(File.read(erb_path))).result(binding), "/etc/ntp.conf"
    run "ntpdate #{ntp_server}"
    run "chkconfig ntpd on"
    run "service ntpd start; sleep 2"
    run "ntpq -p"
  end

end
