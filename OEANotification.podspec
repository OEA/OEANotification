#
# Be sure to run `pod lib lint OEANotification.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "OEANotification"
  s.version          = "0.2.0"
  s.summary          = "OEANotification is the very flexible notification library."
  s.description      = <<-DESC
                        This iOS library provides to create notifications and customize them easily.
                        You can create notifications with just one line of code ,if you are bored UIAlertView.
                       DESC
  s.homepage         = "https://github.com/OEASLAN/OEANotification"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Ömer Aslan" => "omer.aslan@ozu.edu.tr" }
  s.source           = { :git => "https://github.com/OEASLAN/OEANotification.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/OEASLAN'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Classes/**/*'
  s.resource_bundles = {
    'OEANotification' => ['Resources/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
