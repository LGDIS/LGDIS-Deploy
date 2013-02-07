namespace :sshd do
  
  namespace :setup do

    desc "setup sshd"
    task :conf, :roles => [:root] do
      run "chkconfig --level 2345 sshd on"
    end

    desc "sshd test"
    task :checkit, :roles => [:root] do
      run "echo #{application}"
    end
  end
end
