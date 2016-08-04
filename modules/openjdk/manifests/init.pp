class openjdk {
    
    $jdk_version = 7
    
    package { "openjdk$jdk_version":
        name => "openjdk-$jdk_version-jdk",
        ensure => installed,
    }
}