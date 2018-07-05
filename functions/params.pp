function tomcat::params(
  Hash  $options,
  Puppet::LookupContext  $context,
){
    $base_params = {

       'tomcat::username'           =>  'tomcat',
       'tomcat::user_ensure'        =>  'present',
       'tomcat::user_home'          =>  '/opt/tomcat',
       
       'tomcat::user_gid'           =>   1002, 
       'tomcat::groupname'          =>  'tomcat',
       'tomcat::install_path_root'  => '/opt',
       'tomcat::install_path'      => '/opt/tomcat',
       'tomcat::tomcat_filename'   => 'apache-tomcat-9.0.8.tar.gz',
       'tomcat::checksum_val'      =>  '1d081785ff96660ed950478972421d2c',
       'tomcat::tomcat_install'    =>  'apache-tomcat-9.0.8',
       'tomcat::java_home'         =>   '/usr/lib/java/jdk',
       'tomcat::xms'               =>   '512M',
       'tomcat::xmx'               =>   '1024M',
       'tomcat::tensure'           =>   'present',
       'tomcat::service_path'      =>  '/etc/systemd/system',

       'tomcat::service_ensure'    =>  'running',
       'tomcat::service_name'      =>  'tomcat',
       
       'tomcat::service_pattern'    => 'tomcat',
       'tomcat::service_enable'     => true,
       'tomcat::service_hasstatus'  => true,
       'tomcat::service_hasrestart' => true,

      
      }

    $os_params  = case $facts['os']['family'] {
           'Debian': {
                { 'tomcat::user_uid'           =>   1002,
                  'tomcat::user_shell'         =>  '/usr/sbin/nologin',
                  
                   }
             }
            default: { 
                { 'tomcat::user_uid'           =>   1002,
                   'tomcat::user_shell'         =>  '/usr/sbin/nologin',
                 
                      }
             }
       
        }
    $base_params  + $os_params


}

