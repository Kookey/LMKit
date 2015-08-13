Pod::Spec.new do |s|
  s.name         = "LMKit"
  s.version      = "0.0.10"
  s.summary      = "Fast iOS Developer App Kit"
  s.homepage     = "https://github.com/limenglook/LMKit"
  s.license      = "MIT"
  s.authors      = { '李蒙' => 'limenglook@outlook.com'}
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/limenglook/LMKit.git", :tag => s.version }
  s.requires_arc = true
  
  s.public_header_files = 'LMKit/*.h'
  s.source_files = 'LMKit/LMKit.h'
  
  s.subspec 'LMCategory' do |ss|
    ss.source_files = 'LMKit/LMCategory/*.{h,m}'
  end
  
  s.subspec 'LMCountDownButton' do |ss|
    ss.source_files = 'LMKit/LMCountDownButton/*.{h,m}'
  end
  
  s.subspec 'LMPlaceholderView' do |ss|
    ss.source_files = 'LMKit/LMPlaceholderView/*.{h,m}'
  end
  
  s.subspec 'LMWebViewController' do |ss|
    ss.source_files = 'LMKit/LMWebViewController/*.{h,m}'
  end
end
