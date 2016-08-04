class storm_supervisord {

    include storm

    package { 'supervisor':
      ensure => installed,
    }

    file { "storm-ui-ini":
        path => "/etc/supervisord.d/storm-ui.ini",
        ensure => file,
        content => template("storm_supervisord/storm-ui.ini.erb"),
        require => Package['supervisor'],
        notify => Service['supervisord'],
    }
    
    file { "storm-nimbus-ini":
        path => "/etc/supervisord.d/storm-nimbus.ini",
        ensure => file,
        content => template("storm_supervisord/storm-nimbus.ini.erb"),
        require => Package['supervisor'],
        notify => Service['supervisord'],
    }
    
    file { "storm-supervisor-ini":
        path => "/etc/supervisord.d/storm-supervisor.ini",
        ensure => file,
        content => template("storm_supervisord/storm-supervisor.ini.erb"),
        require => Package['supervisor'],
        notify => Service['supervisord'],
    }
    service { "supervisord":
        ensure => running,
        enable => true,
        hasrestart => false,
        hasstatus => false,
    }


}
