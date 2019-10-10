
Pod::Spec.new do |s|

  s.name         = "DYFProgressView"
  s.version      = "1.0.8"
  s.summary      = "Super useful progress bar and web page progress bar."
  s.description  = <<-DESC
	A simple QR code and barcode scanner, which has a set of custom scanning animation and interface, supports camera zooming, and can generate and identify QR code.
                   DESC

  s.homepage     = "https://github.com/dgynfi/DYFProgressView"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "dyf" => "vinphy.teng@foxmail.com" }

  s.platform     = :ios
  s.ios.deployment_target 	= "8.0"
  # s.osx.deployment_target 	= "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target 	= "9.0"

  s.source       = { :git => "https://github.com/dgynfi/DYFCodeScanner.git", :tag => s.version.to_s }

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
