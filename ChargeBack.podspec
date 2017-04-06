Pod::Spec.new do |s|
  s.name             = 'ChargeBack'
  s.summary          = 'ChargeBack is a demo project I did for Nubank contracting process'
  s.version          = '1.1.1'

  s.homepage         = 'git@bitbucket.org/antoinebarrault/nubank-chargeback-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Antoine Barrault' => 'barrault01@gmail.com' }
  s.source           = { :git => "git@bitbucket.org:antoinebarrault/nubank-chargeback-ios.git", :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'ChargeBack/**/*.{swift}'
  s.resources =  "ChargeBack/**/*.{png,jpeg,jpg,storyboard,xcassets,xib}"
  s.frameworks = 'UIKit'
  s.dependency 'NibDesignable', '3.0.0'
  s.dependency 'PKHUD', '4.2.0'
  s.dependency 'Atributika', '3.1.4'
  s.dependency 'HexColors', '~> 5.0'
  s.dependency 'SevenSwitch', '~> 2.1'
  s.exclude_files = 'ChargeBack/**/*Tests.{swift}'

end
