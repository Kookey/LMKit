Pod::Spec.new do |s|
  s.name         = "LMKit"
  s.version      = "0.0.1"
  s.summary      = "Fast Developer App Kit"
  s.homepage     = "https://github.com/limenglook/LMKit"
  s.license      = "MIT"
  s.authors      = { 'limeng' => '921854304@qq.com'}
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/limenglook/LMKit.git", :tag => s.version }
  s.source_files = "LMKit"
  s.requires_arc = true
end
