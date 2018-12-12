Pod::Spec.new do |s|

    s.name = 'AllInMobileSwift'
    s.version = '0.0.5'
    s.summary = 'Biblioteca de push da AllIn'
    s.homepage = 'https://github.com/giep-br/mobile-ios-swift'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.authors = { 'lucasrodrigues' => 'lrodrigues@allin.com.br' }
    s.platform = :ios
    s.ios.deployment_target = '10.0'
    s.requires_arc = true
    s.source = { :git => 'https://github.com/giep-br/mobile-ios-swift.git', :tag => s.version.to_s }
    s.source_files = 'AlliNMobileSwift/*', 'AlliNMobileSwift/**/*', 'AlliNMobileSwift/**/**/*', 'AlliNMobileSwift/**/**/**/*'

end