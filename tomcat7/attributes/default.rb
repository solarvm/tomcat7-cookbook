tc7tarball = "apache-tomcat-7.0.23.tar.gz"
tc7download = "http://mirrors.kahuki.com/apache/tomcat/tomcat-7/v7.0.23/bin/apache-tomcat-7.0.23.tar.gz"
tc7target = "/usr/local"
tc7user = "tomcat"
tc7group = "tomcat"

##
default["tomcat"]["port"] = 8080
default["tomcat"]["ssl_port"] = 8443
default["tomcat"]["ajp_port"] = 8009
node[:tomcat7][:java_options] = " -Xmx128M -Dajva.awt.headless=true"
node[:tomcat7][:use_security_manager] = "no"
##
#set ["tomcat"]["home"] = ""
#set ["tomcat"]["base"] = ""
#set ["tomcat"]["config_dir"] = ""
#set ["tomcat"]["log_dir"] = ""
node[:tomcat7][:home] = "#{tc7target}/tomcat"
node[:tomcat7][:base] = "#{tc7target}/tomcat"
node[:tomcat7][:config_dir] = "#{tc7target}/tomcat/conf"
node[:tomcat7][:log_dir] = "#{tc7target}/tomcat/logs"