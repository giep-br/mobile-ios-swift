Pod::Spec.new do |s|

    s.name = 'AllInMobileSwift'
    s.version = '0.0.17'
    s.summary = 'Biblioteca de push da AllIn'
    s.homepage = 'https://code.allin.com.br/mobile-open/mobile-ios-swift'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.authors = { 'lucasrodrigues' => 'lrodrigues@allin.com.br' }
    s.platform = :ios
    s.ios.deployment_target = '9.0'
    s.requires_arc = true
    s.source = { :git => 'https://code.allin.com.br/mobile-open/mobile-ios-swift', :tag => s.version.to_s }
    s.source_files = 'AlliNMobileSwift/*.{h,m,swift}', 'AlliNMobileSwift/**/**.{h,m,swift}', 'AlliNMobileSwift/**/**/**.{h,m,swift}', 'AlliNMobileSwift/**/**/**/**.{h,m,swift}'
    s.swift_version = '4.2'

end
