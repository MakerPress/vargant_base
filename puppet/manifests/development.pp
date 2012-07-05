stage { [prep, packages, apps]: }
Stage[prep] -> Stage[packages] -> Stage[apps]

# This class updates apt-get and installs pre-requisite packages
class prep {

   group { "puppet": ensure => "present", }

   package { "python-software-properties":
      ensure => installed,
   }

   exec { "add-redis-repo":
      command => "/usr/bin/add-apt-repository ppa:cmsj/redis-stable",
      require => Package["python-software-properties"]
   }

   exec { "apt-update":
      command => "/usr/bin/apt-get update",
      require => Exec["add-redis-repo"],
    }


   package { ["build-essential", "zlib1g-dev", "git-core", "sqlite3", "libsqlite3-dev", "curl", "libicu-dev"]:
      ensure => installed,
      require => Exec["apt-update"]
   }

   file { "/vagrant/.rvmrc":
      content => "rvm use 1.9.2@atlas --create"
   }

}

# Installs RVM
class installrvm {
  include rvm
  rvm::system_user { vagrant: ; }

  rvm_system_ruby {
     'ruby-1.9.2:
         ensure => 'present',
         default_use => true;
   }

}

#Installs redis
class redis {

    exec { "install-redis":
       command => "/usr/bin/apt-get install redis-server",
    }

    service { "redis-server":
        ensure => running,
        enable => true,
        hasrestart => true,
        require => Exec["install-redis"],
    }

}


#Installs the gitapi app
class gitapi {
   
   exec { "clone_gitapi":
      command => "/usr/bin/git clone https://github.com/runemadsen/GitApi /usr/local/app/GitApi",
   }

   exec { "chmod":
      command => "/bin/chown -R vagrant:vagrant /usr/local/app/GitApi/",
      require => Exec["clone_gitapi"],
   }

}

# Installs required app packages
class app-packages {

   $gems = [ 
     "rails",
     "thin"
   ]

   package { $gems :
      ensure => installed,
      provider => 'gem',
   }

}

class { prep: stage => prep }
class { redis: stage => packages }
class { installrvm: stage => packages }
class { gitapi: stage => apps }
class { app-packages: stage => apps }