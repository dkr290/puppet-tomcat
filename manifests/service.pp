class tomcat::service(

  String  $ensure       = $::tomcat::service_ensure,
  String  $service_name = $::tomcat::service_name,
  String  $pattern      = $::tomcat::service_pattern,
  Boolean $enable     = $::tomcat::service_enable,
  Boolean $hasstatus   = $::tomcat::service_hasstatus,
  Boolean $hasrestart  = $::tomcat::service_hasrestart, 





){


service {'tomcat_service':

        ensure     => $ensure,
        name       => $service_name,
        enable     => $enable,
        hasstatus  => $hasstatus,
        hasrestart => $hasrestart,
        pattern    => $pattern,

}
}
