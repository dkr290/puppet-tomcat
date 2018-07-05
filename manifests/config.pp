class tomcat::config(
  
   String $java_home    = $::tomcat::java_home,
   String $install_path = $::tomcat::install_path,
   String $xms          = $::tomcat::xms,
   String $xmx          = $::tomcat::xmx,
   String $username     = $::tomcat::username,
   String $groupname    = $::tomcat::groupname,
   String $ensure       = $::tomcat::tensure,
   String $service_path = $::tomcat::service_path,
   
   
   
   ){

 file {'tomcat.service':
         ensure => $ensure,
         path   => "${service_path}/tomcat.service",
         mode   => '0755',
         owner  => 'root',
         group  => 'root',
         content => template("${module_name}/tomcat.service.erb"),


     }




}
