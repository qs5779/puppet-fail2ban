# Setup a fail2ban jail.
#
define fail2ban::jail (
  Enum['present', 'absent', 'purged'] $ensure,
  Stdlib::Absolutepath                $jail_dir,
  Optional[Boolean]                   $enabled = true,
  Optional[String]                    $jailname = $title,
  Optional[Array[String]]             $port = [],
  Optional[Array[String]]             $logpath = [],
  Optional[String]                    $banaction = undef,
  Optional[String]                    $banaction_allports = undef,
  Optional[Array[String]]             $action = [],
  Optional[Array[String]]             $ignoreip = [],
  Optional[String]                    $ignorecommand = undef,
  Optional[Variant[String,Integer]]   $bantime = undef,
  Optional[String]                    $findtime = undef,
  Optional[Integer]                   $maxretry = undef,
  Optional[String]                    $backend = undef,
  Optional[Enum['yes', 'no', 'warn']] $usedns = undef,
  Optional[String]                    $filter = undef,
  Optional[Array[String]]             $protocol = [],
  Optional[Integer]                   $order = undef,
) {

  if $order { # we intentionally will not use 0 for order, as we use 00 for our overrides
    $jail_path_name = sprintf('%s/%02d-%s.conf', $jail_dir, $order, $jailname)
  }
  else {
    $jail_path_name = sprintf('%s/%s.conf', $jail_dir, $jailname)
  }

  if $ensure == 'present' {
    file { $jail_path_name:
      ensure  => 'file',
      content => template('fail2ban/jail.erb'),
    }
  }
  else {
    file { $jail_path_name:
      ensure => 'absent',
    }
  }
}
