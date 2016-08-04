class storm {

    # $storm_version = hiera('storm.version')
    $storm_version = "0.10.1"
    $storm_release = "apache-storm-$storm_version"
    $nimbus_host = "nimbus"
    $zookeeper_hosts = "zk"
    $supervisor_ports = [ "6700", "6701", "6702", "6703", "6705"]
    $drpc_servers = "none"

    package { 'unzip':
        ensure => installed,
    }

    exec { "storm-download":
        command => "wget http://mirror.bit.edu.cn/apache/storm/$storm_release/$storm_release.zip",
        path => "/usr/bin/:/bin/",
        cwd => "/tmp/",
        unless => "test -f /tmp/$storm_release.zip",
        returns => ["0","1"],
    }

    exec { "storm-unpack":
        command => "unzip -o /tmp/$storm_release -d /usr/share/",
        path => "/usr/bin/:/bin/",
        require => [Package["unzip"]],
    }

    file { "storm-share-symlink":
        path => "/usr/share/storm",
        ensure => link,
        target => "/usr/share/$storm_release",
        require => Exec["storm-unpack"],
    }

    file { "storm-bin-symlink":
        path => "/usr/bin/storm",
        ensure => link,
        target => "/usr/share/$storm_release/bin/storm",
        require => File["storm-share-symlink"],
    }

    group { "storm-group":
        name => "storm",
        ensure     => present,
    }
    user { "storm-user":
        name => "storm",
        ensure     => present,
        gid        => 'storm',
        shell      => '/bin/bash',
        home => "/home/storm",
        managehome => true,
    }

    file { "storm-etc-config-dir":
        path => "/etc/storm/",
        ensure => directory,
        owner => "storm",
        group => "storm",
    }
    
    file { "storm-etc-config":
        path => "/etc/storm/storm.yaml",
        ensure => file,
        content => template("storm/storm.yaml.erb"),
        require => [File['storm-etc-config-dir'], File['storm-share-symlink']],
    }
    
    file { "storm-conf-symlink":
        path => "/usr/share/storm/conf/storm.yaml",
        ensure => link,
        target => "/etc/storm/storm.yaml",
        require => File["storm-etc-config"],
    }

}