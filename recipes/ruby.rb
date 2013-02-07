# -*- coding: utf-8 -*-

namespace :ruby do

  desc "install ruby"
  task :install, :roles => [:root] do
    ruby_version = "1.9.3-p374"
    ruby = "ruby-#{ruby_version}"
    bundler = "bundler-1.2.3.gem"

    # libyamlとlibyaml-develはEPELからダウンロードしてfilesディレクトリに配置
    rpms = [
            "libyaml-0.1.3-1.el6.x86_64.rpm",
            "libyaml-devel-0.1.3-1.el6.x86_64.rpm",
           ]
    rpms.each do |rpm|
      upload "#{CapExample::local_dir}/files/ruby/#{rpm}", rpm
    end

    run "yum -y localinstall #{rpms.join(" ")}"
    run "rm -f *.rpm"
    run "yum install -y readline-devel zlib-devel openssl-devel libxml2-devel libxslt-devel mysql-devel ntp gcc gcc-c++ make"

    upload "#{CapExample::local_dir}/files/ruby/#{ruby}.tar.gz", "#{ruby}.tar.gz"
    run "tar zxvf #{ruby}.tar.gz"
    run "cd #{ruby}; ./configure --prefix=/usr/local/pkgs/rubies/#{ruby_version}; make; make install"
    run "ln -s /usr/local/pkgs/rubies/#{ruby_version} /usr/local/ruby"
    run "rm -rf #{ruby}*"
    upload "#{CapExample::local_dir}/files/ruby/ruby.sh", "/etc/profile.d/ruby.sh"
    run "source ~/.bash_profile"
    upload "#{CapExample::local_dir}/files/ruby/#{bundler}", bundler
    run "gem install --local #{bundler}"
    run "rm -f #{bundler}"
  end
end
