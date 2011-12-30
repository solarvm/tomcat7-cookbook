#
# Cookbook Name:: tomcat7
# Recipe:: default
#
# Copyright 2011,
#
# All rights reserved - Do Not Redistribute
#
tc7tarball = "apache-tomcat-7.0.23.tar.gz"
tc7url = "http://mirrors.kahuki.com/apache/tomcat/tomcat-7/v7.0.23/bin/apache-tomcat-7.0.23.tar.gz"
tc7target = "/usr/local"
tc7user = "tomcat"
tc7group = "tomcat"

remote_file "/tmp/#{tc7tarball}" do
    source "#{tc7url}"
    mode "0644"
    checksum "d8dcd5fb07dd1769d571fdabade9cc68"
end

#execute "addgroup" do
#    user "root"
#    group "root"
#    command "addgroup #{tc7group}"
#    action :run
#end

group "#{tc7group}" do
    action :create
end

#execute "adduser" do
#    user "root"
#    group "root"
#    command "adduser -s /bin/false -g #{tc7group} #{tc7user}"
#    action :run
#end

user "#{tc7user}" do
    comment "Tomcat7 user"
    gid "#{tc7group}"
    home "#{tc7target}"
    shell "/bin/false"
    system true
    action :create
end

directory "#{tc7target}/apache-tomcat-7.0.23" do
    owner "#{tc7user}"
    group "#{tc7group}"
    mode "0755"
    action :create
end

execute "tar" do
    user "#{tc7user}"
    group "#{tc7group}"
    installation_dir = "#{tc7target}"
    cwd installation_dir
    command "tar zxf /tmp/#{tc7tarball}"
    action :run
end

link "#{tc7target}/tomcat" do
    to "apache-tomcat-7.0.23"
    link_type :symbolic
end

case node["platform"]
when "debian","ubuntu"
    template "/etc/init.d/tomcat7" do
	source "init-debian.erb"
	owner "root"
	group "root"
	mode "0755"
    end
    execute "init-deb" do
	user "root"
	group "root"
	command "update-rc.d tomcat7 defaults"
	action :run
    end
else
    template "/etc/init.d/tomcat7" do
	source "init-rh.erb"
	owner "root"
	group "root"
	mode "0755"
    end
    execute "init-rh" do
	user "root"
	group "root"
	command "chkconfig --add tomcat7"
	action :run
    end
end

service "tomcat7" do
    service_name "tomcat7"
    
end
