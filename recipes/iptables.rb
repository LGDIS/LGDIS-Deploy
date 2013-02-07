namespace :iptables do

  task :setup, :roles => [:root] do
    run "mv /etc/sysconfig/iptables{,.#{Time.now.strftime('%Y%m%d%H%M%S')}}"
    upload "#{CapExample::local_dir}/files/iptables/iptables", "/etc/sysconfig/iptables"
    run "/etc/init.d/iptables restart; sleep 3"
  end

end
