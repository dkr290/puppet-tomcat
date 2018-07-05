class tomcat(
   $username,
   $user_ensure,
   $user_home,
   $user_shell,
   $user_uid,
   $user_gid,
   $groupname,
   $install_path_root,
   $install_path,
   $tomcat_filename,
   $checksum_val,
   $tomcat_install,
   $java_home,
   $xms,
   $xmx,
   
   $service_path,
   $tensure,
   $service_ensure,
   $service_name,
   $service_pattern,
 $service_enable,
 $service_hasstatus,
 $service_hasrestart,

) {
   
   class {'::tomcat::users':
   
   before => Class['::tomcat::install'],
    }
    
   class {'::tomcat::install':
    notify => Class['::tomcat::service'],
   }

   class {'::tomcat::config':
   
   }

   class {'::tomcat::service':
   
   subscribe => Class['::tomcat::config'],
   }


}
