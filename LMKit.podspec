Pod::Spec.new do |s|
  s.name         = "LMKit"
  s.version      = "0.0.23"
  s.summary      = "Fast iOS Developer App Kit"
  s.homepage     = "https://github.com/limenglook/LMKit"
  s.license      = "MIT"
  s.authors      = { '李蒙' => 'limenglook@outlook.com'}
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/limenglook/LMKit.git", :tag => s.version }
  s.source_files = "LMKit/**/*.{h,m}"
  s.requires_arc = true
end