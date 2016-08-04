class openjdk {
    
    $jdk_version = hiera('jdk.version')
    
    package { "openjdk$jdk_version":
        name => "openjdk-$jdk_version-jdk",
        ensure => installed,
    }
}