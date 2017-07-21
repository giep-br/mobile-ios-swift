Pod::Spec.new do |s|

    s.name = 'AllInMobileSwift'
    s.version = '0.0.1'
    s.summary = 'Biblioteca de push da AllIn'
    s.homepage = 'https://github.com/giep-br/mobile-ios-swift'
    s.license = {
        :type => 'MIT',
        :file => 'LICENSE'
    }
    s.author = {
        'lucasrodrigues' => 'lrodrigues@allin.com.br'
    }
    s.source = {
        :git => 'https://github.com/giep-br/mobile-ios-swift',
        :tag => s.version.to_s
    }
    s.platform = :ios
    s.requires_arc = true
    s.source_files = 'AlliNMobileSwift/*', 'AlliNMobileSwift/**/*'
    s.module_map = 'CommonCryptoModuleMap/module.modulemap'
    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2', 'SWIFT_INCLUDE_PATHS' => '${PODS_ROOT}/CommonCryptoModuleMap' }

end