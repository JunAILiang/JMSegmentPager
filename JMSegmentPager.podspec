

Pod::Spec.new do |s|

  s.name         = "JMSegmentPager"
  s.version      = "0.1.3"
  s.summary      = "打造一个高性能、零耦合的分段控制器"

  s.description  = <<-DESC
  					       修复已知Bug
                   DESC

  s.homepage     = "https://github.com/JunAILiang/JMSegmentPager.git"

  s.license      = "MIT"

  s.author       = { "LJM" => "gzliujm@163.com" }

  s.platform	= :ios, "8.0"

  s.source       = { :git => "https://github.com/JunAILiang/JMSegmentPager.git", :tag => "#{s.version}" }

  s.source_files  = "JMSegmentPager/JMSegmentPager/**/*.{h,m}"

  s.requires_arc = true

end
