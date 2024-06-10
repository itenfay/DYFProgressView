
Pod::Spec.new do |s|
  s.name         = "DYFProgressView"
  s.version      = "1.2.0"
  s.summary      = "Super useful progress bar and web page progress bar."
  s.description  = <<-DESC
  Super useful progress bar and web page progress bar, the operation is simple and easy to use.
  DESC

  s.homepage     = "https://github.com/itenfay/DYFProgressView"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "Tenfay" => "hansen981@126.com" }

  s.platform     = :ios
  s.ios.deployment_target 	= "8.0"
  # s.osx.deployment_target 	= "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target 	= "9.0"

  s.source       = { :git => "https://github.com/itenfay/DYFProgressView.git", :tag => s.version.to_s }

  s.source_files  = "Classes/**/*.{h,m}"
  s.public_header_files = "Classes/**/*.h"

  # s.resource  = "icon.png"
  # s.resources = "Resource/*.bundle"

  s.frameworks = "Foundation", "UIKit"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
end
