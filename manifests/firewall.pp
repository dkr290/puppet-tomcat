define tomcat::firewall(

Integer $dport = 80,
String  $proto = 'tcp',
String $action = 'accept',
String $ensure  = 'present',
String $zone    = 'public',





){

case $facts['os']['family'] {
           'Debian': {
          



              firewall { "${name}":
                        dport  => $dport,
                        proto  => $proto,
                        action => $action,
                           }
             }
            'RedHat', 'CentOS': { 
             

                    


                           firewalld_port { "${name}":
                             ensure   => $ensure,
                             zone     => $zone,
                             port     => $dport,
                            protocol => $proto,
                         }
                 
                      }
                      default: {
                        notify { "os not supported":
                          message => 'the os is not supported',
                        }
                    }
          
      }
  }
