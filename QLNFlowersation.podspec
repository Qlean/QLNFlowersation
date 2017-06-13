Pod::Spec.new do |s|
  s.name     = 'QLNFlowersation'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'Chat bot framework'
  s.homepage = 'https://github.com/Qlean/QLNFlowersation'
  s.authors  = { 'Andrey Konstantinov' => '8ofproject@gmail.com' }
  s.source   = { :git => 'https://github.com/Qlean/QLNFlowersation', :tag => s.version, :submodules => true }
  s.requires_arc = true
  s.ios.deployment_target = '9.0'

  s.public_header_files = 'QLNFlowersation/QLNFlowersation.h'
  s.source_files = 'QLNFlowersation/**/*.swift', 'QLNFlowersation/QLNFlowersation.h'
  s.resources = 'QLNFlowersation/**/*.xib', 'QLNFlowersation/Media.xcassets'

  s.dependency 'Alamofire', '4.4.0'
  s.dependency 'AlamofireImage', '3.2.0'
  s.dependency 'PureLayout', '3.0.2'

end
