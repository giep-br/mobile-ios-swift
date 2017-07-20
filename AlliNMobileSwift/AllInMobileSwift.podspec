Pod::Spec.new do |s|

    s.name              = 'AlliNMobileSwift'
    s.version           = '0.0.1'
    s.summary           = 'Biblioteca de push da AllIn'
    s.homepage          = 'https://github.com/giep-br/mobile-ios-swift'
    s.license           = {
        :type => 'MIT',
        :file => 'LICENSE'
    }
    s.author            = {
        'lucasrodrigues' => 'lrodrigues@allin.com.br'
    }
    s.source            = {
        :git => 'https://github.com/giep-br/mobile-ios-swift',
        :tag => s.version.to_s
    }
    s.platform = :ios
    s.source_files      = 'AlliNMobileSwift/*.swift', 'AlliNMobileSwift/Extension/*.swift', 'AlliNMobileSwift/Constant/*.swift', 'AlliNMobileSwift/Helper/*.swift', 'AlliNMobileSwift/Error/*.swift', 'AlliNMobileSwift/Delegate/*.swift', 'AlliNMobileSwift/Request/*.swift', 'AlliNMobileSwift/Service/*.swift', 'AlliNMobileSwift/WebView/*.swift'
    s.requires_arc      = true

end