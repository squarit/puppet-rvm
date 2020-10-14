# Default module parameters
class rvm::params($manage_group = true) {

  $manage_rvmrc = $facts['os']['family'] ? {
    'Windows' => false,
    default   => true
  }

  $group = $facts['os']['name'] ? {
    default => 'rvm',
  }

  $proxy_url = undef
  $no_proxy = undef
  $key_server = 'hkp://keys.gnupg.net'

  # install the gpg key if gpg is installed or being installed in this puppet run
  if defined(Class['::gnupg']) or $facts['gnupg_installed'] {
    $gnupg_key_id = ['D39DC0E3', '39499BDB']
  } else {
    $gnupg_key_id = []
  }

  # ignored param, using gnupg module
  $gpg_package = $::kernel ? {
    /(Linux|Darwin)/ => 'gnupg2',
    default          => undef,
  }
}
