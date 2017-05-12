
Pod::Spec.new do |s|

  s.name         = "YLActionContext"
  s.version      = "0.0.1"
  s.summary      = "One-to-one communication between objects in Objective-C."

  s.description  = <<-DESC
                   YLActionContext is used for one-to-one communication between objects.
                   DESC

  s.homepage     = "https://github.com/IceCreamWu/YLActionContext"
  s.license      = "MIT"
  s.author       = { "IceCreamWu" => "286407114@qq.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/IceCreamWu/YLActionContext.git", :tag => "0.0.1" }
  s.source_files  = "YLActionContext/*.{h,m}"
  s.requires_arc = true

end
