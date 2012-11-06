# == Class: ldap
#
# Manage LDAP client configuration.
#
# Currently only supports Ubuntu.  Tested on Ubuntu 12.04.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { ldap:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
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
class ldap {

  case $::operatingsystem {
    ubuntu: {
      $pkgs = [ 'ldap-utils', 'libnss-ldap', 'libpam-krb5' ]
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }

  package { $pkgs: ensure => installed }

}
