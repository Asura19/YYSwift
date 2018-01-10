Pod::Spec.new do |s|

  s.name         = "YYSwift"
  s.version      = "1.0.0"
  s.summary      = "A handy collection of native Swift extensions"

  s.description  = <<-DESC
  YYSwift is a collection of native Swift extensions, with handy methods, syntactic sugar, and performance improvements for wide range of primitive data types, UIKit and Cocoa classes –over 500 in 1– for iOS, macOS, tvOS and watchOS.
                   DESC

  s.homepage     = "https://github.com/Asura19/YYSwift"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { type: "MIT", file: "LICENSE" }
  s.author             = { "Phoenix" => "x.rhythm@qq.com" }
  s.social_media_url   = "https://twitter.com/phoenixnirvana7"

  s.ios.deployment_target = "10.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "4.0"
  s.tvos.deployment_target = "10.0"

  s.requires_arc = true
  s.source       = { git: "https://github.com/Asura19/YYSwift.git", tag: s.version.to_s }


  s.source_files  = "Sources", "Sources/**/*.{swift,h,map}"
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '4.0'
  }

end
