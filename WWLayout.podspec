#
#  Be sure to run `pod spec lint WWLayout.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "WWLayout"
  s.version      = "0.5.0"
  s.summary      = "An easy way to add layout constraints"
  s.description  = "WWLayout is an easy way to add layout constraints with code."
  s.homepage     = "https://github.com/ww-tech/wwlayout"

  s.license      = "MIT"
  s.author       = { "Steven Grosmark" => "steven.grosmark@weightwatchers.com" }
  s.platform     = :ios, "9.0"
  
  s.source       = { :git => "https://github.com/ww-tech/wwlayout.git", :tag => s.version.to_s }
  s.source_files = "Sources/WWLayout", "Sources/WWLayout/**/*.{h,m,swift}"

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }

end
