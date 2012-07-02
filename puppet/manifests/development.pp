
class requirements {

  file { '/etc/redis/hello.txt':
     ensure => file,
     source => "puppet:///modules/local_files/hello.txt",
  }

  file { '/etc/redis/wilson.txt':
     ensure => file,
     source => "puppet:///modules/local_files/wilson.txt",
  }

}

include requirements