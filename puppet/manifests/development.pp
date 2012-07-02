
class requirements {
  group { "puppet": ensure => "present", }
  exec { "apt-update":
    command => "/usr/bin/apt-get -y update"
  }

  package {
    ["redis-server", "git-core"]: 
      ensure => installed,
  }
}

include requirements