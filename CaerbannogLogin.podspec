#
# Be sure to run `pod lib lint CaerbannogLogin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CaerbannogLogin'
  s.version          = '0.0.1'
  s.summary          = 'A easy framework to add login system in your app'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A easy framework to add login system in your ios app.
                       DESC

  s.homepage         = 'https://github.com/dbarbos/CaerbannogLogin'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'leodegeus7' => 'leonardodegeus@gmail.com' }
  s.source           = { :git => 'https://github.com/dbarbos/CaerbannogLogin.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CaerbannogLogin/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CaerbannogLogin' => ['CaerbannogLogin/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
