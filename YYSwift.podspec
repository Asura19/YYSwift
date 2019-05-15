Pod::Spec.new do |spec|

  spec.name         = "YYSwift"
  spec.version      = "1.1.1"
  spec.summary      = "Native Swift extensions."
  spec.homepage     = "https://github.com/Asura19/YYSwift"
  spec.license      = "MIT"

  spec.author             = { "Phoenix" => "yy@surax.cn" }
  spec.social_media_url   = "https://weibo.com/phoenix19"

  spec.source       = { :git => "https://github.com/Asura19/YYSwift.git", :tag => "1.1.1" }

  spec.ios.deployment_target = "10.0"
  spec.osx.deployment_target = "10.10"
  spec.watchos.deployment_target = "4.0"
  spec.tvos.deployment_target = "10.0"


  s.swift_version = '5.0'

  s.source_files = 'Source/*.swift'
end
