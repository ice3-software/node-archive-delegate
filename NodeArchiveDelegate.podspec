#
# Be sure to run `pod lib lint node-archive-delegate.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "NodeArchiveDelegate"
  s.version          = "0.1.0"
  s.summary          = "A tricksey d."
  s.description      = <<-DESC
                       A tricksy archive delegate that subclasses your SKNodes by name.
                       DESC
  s.homepage         = "https://github.com/ice3-software/node-archive-delegate"
  s.license          = 'MIT'
  s.author           = { "stephen fortune" => "steve.fortune@icecb.com" }
  s.source           = { :git => "https://github.com/ice3-software/node-archive-delegate.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/IceCubeSoftware'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {}

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'SpriteKit'
end
