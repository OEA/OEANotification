Pod::Spec.new do |s|
  s.name             = 'OEANotification'
  s.version          = '0.1.0'
  s.summary          = 'A short description of OEANotification.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/OEA/OEANotification'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'OEA' => 'omeremreaslan@gmail.com' }
  s.source           = { :git => 'https://github.com/OEA/OEANotification.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'OEANotification/Classes/**/*'

  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit', '~> 4.0'
end
