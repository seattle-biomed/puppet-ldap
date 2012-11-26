# == Class: ldap
#
# Manage LDAP client configuration.
#
# Currently only supports Ubuntu.  Tested on Ubuntu 12.04.
#
# === Parameters
#
# [*base*]
#   /etc/ldap.conf: The distinguished name of the LDAP search base.
#
# [*binddn*]
#   /etc/ldap.conf: The distinguished name to bind to the server with.
#
# [*hosts*]
#   Array used to populate "host" in /etc/ldap.conf: Your LDAP server. Must be
#   resolvable without using LDAP. (Note that this module only supports using
#   "host" and not "uri".)
#
# === Examples
#
#  class { ldap:
#    hosts => [ 'ldap01.example.com', 'ldap02.example.com' ]
#  }
#
# === Authors
#
# Andrew Leonard
#
# === Copyright
#
# Copyright 2012 Andrew Leonard, Seattle Biomedical Research Institute
#
class ldap (
  $base = 'dc=example,dc=net',
  $binddn = false,
  $hosts = [ '127.0.0.1' ]
  ) {

  case $::operatingsystem {
    ubuntu: {
      $pkgs = [ 'ldap-utils', 'libnss-ldap' ]
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

  package { $pkgs: ensure => installed }

  file { '/etc/ldap.conf':
    ensure  => present,
    content => template('ldap/ldap.conf.erb'),
  }
}
