# RVM's GPG key import

class rvm::gnupg_key(
  $key_id = $rvm::params::gnupg_key_id,
  $key_server = $rvm::params::key_server) inherits rvm::params {

  $key_id.each |String $id| {
    gnupg_key { "rvm_${id}":
      ensure     => present,
      key_id     => $id,
      user       => 'root',
      key_server => $key_server,
      key_type   => public,
    }
  }
}
