Pod::Spec.new do |spec|
  spec.name         = 'MOIRefreshControl'
  spec.version      = '0.0.1'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/mconintet/MOIRefreshControl'
  spec.authors      = { 'mconintet' => 'mconintet@gmail.com' }
  spec.summary      = 'Custom refresh control in Object-C for iOS'
  spec.source       = { :git => 'https://github.com/mconintet/MOIRefreshControl.git', :tag => '0.0.1' }
  spec.source_files = 'MOIRefreshControl'
  spec.ios.deployment_target = '9.0'
end