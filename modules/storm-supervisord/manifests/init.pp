class storm-supervisord {

    include storm

    package { 'supervisor':
      ensure => installed,
    }

    file { "storm-ui-conf":
        path => "/etc/supervisord.d/storm-ui.conf",
        ensure => file,
        content => template("storm-supervisor/storm-ui.conf.erb"),
        require => Package['supervisor'],
        notify => Service['supervisor'],
    }
    
    file { "storm-nimbus-conf":
        path => "/etc/supervisord.d/storm-nimbus.conf",
        ensure => file,
        content => template("storm-supervisor/storm-nimbus.conf.erb"),
        require => Package['supervisor'],
        notify => Service['supervisor'],
    }
    
    file { "storm-supervisor-conf":
        path => "/etc/supervisord.d/storm-supervisor.conf",
        ensure => file,
        content => template("storm-supervisor/storm-supervisor.conf.erb"),
        require => Package['supervisor'],
        notify => Service['supervisor'],
    }
    service { "supervisor":
        ensure => running,
        enable => true,
        hasrestart => false,
        hasstatus => false,
    }


}