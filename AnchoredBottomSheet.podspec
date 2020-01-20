#
# Be sure to run `pod lib lint AnchoredBottomSheet.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AnchoredBottomSheet'
  s.version          = '0.1.2'
  s.summary          = 'iOS Maps like bottom sheet with configurable anchors and reusable pannable View'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/havebeenfitz/AnchoredBottomSheet'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'havebeenfitz' => 'max.kraev@gmail.com' }
  s.source           = { :git => 'https://github.com/havebeenfitz/AnchoredBottomSheet.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'AnchoredBottomSheet/Classes/**/*'
  
  s.resource_bundles = {
    'AnchoredBottomSheet' => ['AnchoredBottomSheet/Assets/*']
  }
  s.dependency 'SnapKit', '~> 5.0'
end
