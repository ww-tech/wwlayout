#
#  Be sure to run `pod spec lint WWLayout.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name            = "WWLayout"
  s.version         = "0.8.1"
  s.summary         = "Swifty DSL for programmatic Auto Layout in iOS"
  s.description     = "WWLayout is an elegant way to add auto-layout constraints with code."
  s.homepage        = "https://ww-tech.github.io/wwlayout/"

  s.license         = "Apache-2.0"
  s.author          = { "Steven Grosmark" => "steven.grosmark@weightwatchers.com" }
  s.platform        = :ios, "9.0"
  s.swift_versions  = '4.0', '4.2', '5', '5.1', '5.2', '5.3'
  
  s.source          = { :git => "https://github.com/ww-tech/wwlayout.git", :tag => s.version.to_s }
  s.source_files    = "Sources/WWLayout", "Sources/WWLayout/**/*.{h,m,swift}"

end
