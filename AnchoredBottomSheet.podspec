#
# Be sure to run `pod lib lint AnchoredBottomSheet.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AnchoredBottomSheet'
  s.version          = '1.0.1'
  s.summary          = 'iOS Maps like bottom sheet with configurable anchors and reusable pannable View'

  s.description      = <<-DESC
This small library tries to achieve this goals:
1. Provide an easy to use interface to create popup like controller with configurable anchor points
2. Provide a reusable view that can be used without a popup for some UI cases (split screen for example). Used that way the BottomSheetView will handle it's own pan gesture
                       DESC

  s.homepage         = 'https://github.com/havebeenfitz/AnchoredBottomSheet'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'havebeenfitz' => 'max.kraev@gmail.com' }
  s.source           = { :git => 'https://github.com/havebeenfitz/AnchoredBottomSheet.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'Sources/AnchoredBottomSheet/**/*'

  s.dependency 'SnapKit', '~> 5.0'
end
