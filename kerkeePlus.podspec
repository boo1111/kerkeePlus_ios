
Pod::Spec.new do |spec|
 
  spec.name         = "kerkeePlus"
  spec.version      = "0.0.2"
  spec.summary      = "A short description of kerkeePlus."
  spec.description  = "kerkee的加强版，dek的部署封装"
  spec.homepage     = "http://wiki.ops.yangege.cn/pages/viewpage.action?pageId=12237479"
  spec.license      = "GNU"
  spec.author             = { "hongzhong" => "hongzhong@gegejia.com" }
  spec.social_media_url   = "http://www.kerkee.com"
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/boo1111/kerkeePlus_ios", :tag => "#{spec.version}", :submodules => true }#你的仓库地址，不能用SSH地址
  spec.source_files  = "kerkeePlus/**/*.{h,m}"
  spec.public_header_files = "kerkeePlus/**/*.h"
  spec.vendored_frameworks = "dependencies/*.framework"
  spec.dependency 'SSKeychain','~> 1.2.3'
  spec.dependency 'kerkee','~> 0.0.6'
  spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
