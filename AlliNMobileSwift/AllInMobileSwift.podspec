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
        :git => 'https://github.com/giep-br/mobile-ios-swift.git',
        :tag => s.version.to_s
    }
    s.platform = :ios
    s.requires_arc = true
    s.source_files = 'AlliNMobileSwift/*.swift', 'AlliNMobileSwift/**/*.swift'
    s.preserve_paths = 'AlliNMobileSwift/CommonCrypto/module.modulemap'

end