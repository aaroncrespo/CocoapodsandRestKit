Pod::Spec.new do |s|
  s.name         =  'RestKit'
  s.version      =  '0.20.0'
  s.summary      =  'RestKit is a framework for consuming and modeling RESTful web resources on iOS and OS X.'
  s.homepage     =  'http://www.restkit.org'
  s.author       =  { 'Blake Watters' => 'blakewatters@gmail.com' }
  s.source       =  { :git => 'https://github.com/RestKit/RestKit.git', :branch => 'feature/reboot-networking-layer' }
  s.license      =  'Apache License, Version 2.0'
  
  # Platform setup
  s.requires_arc = true
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  
  # Exclude optional Search and Testing modules
  s.preferred_dependency = 'Core'

  ### Subspecs
  
  s.subspec 'Core' do |cs|
    cs.source_files =  'Code/*.h'
    cs.header_dir   =  'RestKit'
    
    cs.dependency 'RestKit/ObjectMapping'
    cs.dependency 'RestKit/Network'
    cs.dependency 'RestKit/CoreData'
  end
  
  s.subspec 'ObjectMapping' do |os|
    os.header_dir     = 'RestKit/ObjectMapping'
    os.source_files   = 'Code/ObjectMapping'
    os.dependency     'ISO8601DateFormatter', '>= 0.6'
  end
  
  s.subspec 'Network' do |ns|
    ns.header_dir     = 'RestKit/Network'
    ns.source_files   = 'Code/Network'
    ns.ios.frameworks = 'CFNetwork', 'Security', 'MobileCoreServices', 'SystemConfiguration'
    ns.osx.frameworks = 'CoreServices', 'Security', 'SystemConfiguration'
    ns.dependency       'LibComponentLogging-NSLog', '>= 1.0.4'
    ns.dependency       'SOCKit'
    ns.dependency       'AFNetworking', :head # '1.0'
    ns.dependency       'RestKit/ObjectMapping'
    ns.dependency       'RestKit/Support'
  end    
  
  s.subspec 'CoreData' do |cdos|
    cdos.header_dir   = 'RestKit/CoreData'
    cdos.source_files = 'Code/CoreData'
    cdos.frameworks   = 'CoreData'
  end
  
  s.subspec 'Testing' do |ts|
    ts.header_dir   = 'RestKit/Testing'
    ts.source_files = 'Code/Testing'
  end
  
  s.subspec 'Search' do |ss|
    ss.header_dir     = 'RestKit/Search'
    ss.source_files   = 'Code/Search'
    ss.dependency 'RestKit/CoreData'
  end
  
  s.subspec 'Support' do |ss|
    ss.header_dir     = 'RestKit/Support'
    ss.source_files   = 'Code/Support'
  end
end
