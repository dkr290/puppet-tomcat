class tomcat::install(
   $install_path_root   = $::tomcat::install_path_root,
   $install_path        = $::tomcat::install_path,
   $tomcat_filename     = $::tomcat::tomcat_filename,
   $checksum_val        = $::tomcat::checksum_val,
   $tomcat_install          = $::tomcat::tomcat_install,




){

include '::archive'

if $facts['os']['family'] == 'Debian' {
           
  package {'iptables-persistent':
                ensure => 'installed',
              }
           }
           
           
           


  file { $install_path:
  ensure => directory,
  owner  => 'tomcat',
  group  => 'tomcat',
  mode   => '0755',

 }

 archive { "${install_path}/${tomcat_filename}":
 path          => "/opt/${tomcat_filename}",
 source        => "puppet:///modules/tomcat/${tomcat_filename}",
 checksum_type      => 'md5',
 checksum          => $checksum_val,
 extract       => true,
 extract_command => 'tar xfz %s --strip-components=1',
 extract_path  => "${install_path}",
 cleanup       => true,
 user          => 'tomcat',
 group         => 'tomcat',
 require       => File[$install_path],
}





  exec { 'conf':
      path    => ['/usr/bin', '/usr/sbin','/bin',],
      command => "chmod -R g+rx ${install_path}/conf",
      refreshonly => true,
      subscribe   => Archive["${install_path}/${tomcat_filename}"]

    }

      exec { 'ownership':
      path    => ['/usr/bin', '/usr/sbin','/bin',],
      cwd     => "${install_path}",
      command => "chown -R tomcat webapps/ work/ temp/ logs/",
      refreshonly => true,
      subscribe  => Exec['conf']
       
    }
}
