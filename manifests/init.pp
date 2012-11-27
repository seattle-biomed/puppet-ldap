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
# [*bind_timelimit*]
#   /etc/ldap.conf: Bind/connect time limit.
#
# [*binddn*]
#   /etc/ldap.conf: The distinguished name to bind to the server with.
#
# [*bindpw*]
#   /etc/ldap.conf: Credentials used by binddn to bind with.
#
# [*hosts*]
#   Array used to populate "host" in /etc/ldap.conf: Your LDAP server. Must be
#   resolvable without using LDAP. (Note that this module only supports using
#   "host" and not "uri".)
#
# [*map_cn*]
#   /etc/ldap.conf: cn attribute mapping.
#
# [*map_gecos*]
#   /etc/ldap.conf: gecos attribute mapping.
#
# [*map_gidNumber*]
#   /etc/ldap.conf: gidNumber attribute mapping.
#
# [*map_homeDirectory*]
#   /etc/ldap.conf: homeDirectory attribute mapping.
#
# [*map_loginShell*]
#   /etc/ldap.conf: loginShell attribute mapping.
#
# [*map_posixAccount*]
#   /etc/ldap.conf: posixAccount objectclass mapping.
#
# [*map_posixGroup*]
#   /etc/ldap.conf: posixGroup objectclass mapping.
#
# [*map_shadowAccount*]
#   /etc/ldap.conf: shadowAccount objectclass mapping.
#
# [*map_uidNumber*]
#   /etc/ldap.conf: uidNumber attribute mapping.
#
# [*map_uniqueMember*]
#   /etc/ldap.conf: uniqueMember attribute mapping.
#
# [*map_userPassword*]
#   /etc/ldap.conf: userPassword attribute mapping.
#
# [*pam_filter*]
#   /etc/ldap.conf: Filter to AND searches with uid=%s
#
# [*pam_login_attribute*]
#   /etc/ldap.conf: The user ID attribute (defaults to uid).
#
# [*pam_member_attribute*]
#   /etc/ldap.conf: Group member attribute.
#
# [*pam_passwd*]
#   /etc/ldap.conf: Define method for changing password on LDAP server.
#
# [*pam_password_prohibit_message*]
#   /etc/ldap.conf: Redirect users to a URL or somesuch on password changes.
#
# [*rootbinddn*]
#   /etc/ldap.conf: DN to bind to the server with if EUID is 0.
#
# [*scope*]
#   /etc/ldap.conf: Search scope.
#
# [*timelimit*]
#   /etc/ldap.conf: Search time limit.
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
  $bind_policy = 'hard',
  $bind_timelimit = 30,
  $binddn = false,
  $bindpw = false,
  $hosts = [ '127.0.0.1' ],
  $map_cn = false,
  $map_gecos = false,
  $map_gidNumber = false,
  $map_homeDirectory = false,
  $map_loginShell = false,
  $map_posixAccount = false,
  $map_posixGroup = false,
  $map_shadowAccount = false,
  $map_uidNumber = false,
  $map_uniqueMember = false,
  $map_userPassword = false,
  $pam_filter = false,
  $pam_login_attribute = 'uid',
  $pam_member_attribute = 'uniquemember',
  $pam_passwd = 'md5',
  $pam_password_prohibit_message = false,
  $rootbinddn = false,
  $scope = 'sub',
  $timelimit = 30
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
