# tomcat

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with tomcat](#setup)
    * [What tomcat affects](#what-tomcat-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with tomcat](#beginning-with-tomcat)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This is the module that installs tomcat.

It depends on the following modules

puppetlabs/firewall
crayfishx/firewalld
puppet/archive


## Setup
Hiera sample for node1 which is Debian. Hiera file is used for firewall rules

data/node1.yaml Debian server
    ---<br />
    profile::tomcat::rules:<br />
    - 'name': '80 port'<br />
      'proto': 'tcp'<br />
      'dport':  80
      'action': 'accept'
    - 'name': '8080 port'
      'proto': 'tcp'
      'dport':  8080
      'action': 'accept'
###data/node2.yaml
###Centos server


---
profile::tomcat::rules:
 - 'name': 'Open port 8080 in the public zone'
   'ensure': 'present'
   'zone': 'public'
   'port': 8080
   'protocol': 'tcp'

####This is the sample profile module. The file can be called tomcat.pp
The rules from hierra are going to $rules array and then depending on the OS they are implemented

class profile::tomcat(

  Array $rules,

){
  include ::java
  include ::tomcat


case $facts['os']['family'] {
           'Debian': {
  $rules.each |$rule| {

     ::tomcat::firewall {$rule['name']:
          dport => $rule['dport'],
          proto => $rule['proto'],
          action => $rule['action'],

     }

   }
 }
'RedHat', 'CentOS': {


 $rules.each  |$f| {

   ::tomcat::firewall {$f['name']:

          ensure => $f['ensure'],
          zone  =>  $f['zone'],
          port  =>  $f['port'],
          protocol => $f['protocol'],

      }

 }
}




    }

 }



### What tomcat affects **OPTIONAL**

If it's obvious what your module touches, you can skip this section. For
example, folks can probably figure out that your mysql_instance module affects
their MySQL instances.

If there's more that they should know about, though, this is the place to mention:

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute.
* Dependencies that your module automatically installs.
* Warnings or other important notices.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you might want to include an additional "Upgrading" section
here.

### Beginning with tomcat

The very basic steps needed for a user to get the module up and running. This
can include setup steps, if necessary, or it can be an example of the most
basic use of the module.

## Usage

This section is where you describe how to customize, configure, and do the
fancy stuff with your module here. It's especially helpful if you include usage
examples and code samples for doing things with your module.

## Reference

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

This is where you list OS compatibility, version compatibility, etc. If there
are Known Issues, you might want to include them under their own heading here.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel
are necessary or important to include here. Please use the `## ` header.
