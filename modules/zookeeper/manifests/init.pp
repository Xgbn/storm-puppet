class zookeeper {
    
    include openjdk
    
    package { 'zookeeper':
        ensure => "3.4.6*",
    }
    package { 'zookeeperd':
        ensure => "3.4.6*",
        require => Package["zookeeper"],
    }
}