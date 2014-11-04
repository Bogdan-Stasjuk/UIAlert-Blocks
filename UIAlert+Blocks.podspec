Pod::Spec.new do |s|
  s.name             	= "UIAlert+Blocks"
  s.version          	= "1.0.1"
  s.summary          	= "A category on UIAlertView for using blocks instead of delegate methods with enums for most standard titles and button names."
  s.description      	= "A cetogory on UIAlertView that adds blocks and button titles enums. Handy and clear methods that save from using delegation."
  s.homepage         	= "https://github.com/Bogdan-Stasjuk/UIAlert-Blocks"
  s.license      		= { :type => 'MIT', :file => 'LICENSE' }
  s.author           	= { "Bogdan Stasjuk" => "Bogdan.Stasjuk@gmail.com" }
  s.source           	= { :git => "https://github.com/Bogdan-Stasjuk/UIAlert-Blocks.git", :tag => '1.0.1' }
  s.social_media_url = 'https://twitter.com/Bogdan_Stasjuk'
  s.platform     		= :ios, '6.0'
  s.requires_arc 	= true
  s.source_files 	= 'UIAlert+Blocks/*.{h,m}'
  s.public_header_files   	= 'UIAlert+Blocks/*.h'
end
