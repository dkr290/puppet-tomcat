class tomcat::users(

    String $username    = $::tomcat::username,
    String $user_ensure = $::tomcat::user_ensure,
    String $user_home   = $::tomcat::user_home,
    String $user_shell  = $::tomcat::user_shell,
    Integer $user_uid   = $::tomcat::user_uid,
    Integer $user_gid   = $::tomcat::user_gid,
    String $groupname  =  $::tomcat::groupname,



){

   user {'tomcat_user':
   
     ensure => $ensure,
     name   => $username,
     home   => $user_home,
     shell  => $user_shell,
     uid    => $user_uid,
     gid    => $user_gid,
     require => Group['tomcat_group'],
   }

   group {'tomcat_group':
      ensure => $ensure,
      name   => $groupname,
      gid    => $user_gid,
   
   }





}
