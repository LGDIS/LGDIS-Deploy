# -*- coding: utf-8 -*-

namespace :rubygems do

  desc "install rubygems"
  task :install, :roles => [:root] do
    rdoc_version = "3.4"
    rdoc = "rdoc-#{rdoc_version}"
    rubygems_version = "1.8.24"
    rubygems = "rubygems-#{rubygems_version}"
    ulist  = [
            "rubygems-1.8.24.tgz",
            "rdoc-3.4.gem"
           ]
    fileupload ulist 
    run "tar zxvf #{rubygems}.tgz" 
    run "cd #{rubygems}; ruby ./setup.rb"
    run "rm -rf #{rubygems}*"
    run "gem install -l #{rdoc}.gem"
    run "rm -rf #{rdoc}*"
  end

def fileupload(ulist)
    ulist.each do |filen|
      upload  "#{CapExample::local_dir}/files/rubygems/#{filen}", filen 
      #run "echo #{filen}" 
    end
end
end
