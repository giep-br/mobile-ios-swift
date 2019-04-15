//
//  AlliNWebViewController.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 14/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class AlliNWebViewController : UIViewController, UIWebViewDelegate {
    var userInfo: NSDictionary = [:];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.initViews();
        self.initInfos();
    }
    
    // MARK: Outlets
    var progressBar : UIActivityIndicatorView? = nil;
    var webView : UIWebView? = nil;
    var html: String = "";
    
    
    // MARK: Animation ProgressBar
    func startLoad() {
        progressBar!.startAnimating();
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
    }
    
    func stopLoad() {
        progressBar!.stopAnimating();
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false;
    }
    
    func initViews() {
        self.webView = UIWebView(frame: self.view.bounds);
        self.webView!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight];
        self.webView!.delegate = self;
        
        self.progressBar = UIActivityIndicatorView(style: .gray);
        self.progressBar!.center = self.view.center;
        
        self.view.addSubview(self.webView!);
        self.view.addSubview(self.progressBar!);
        
        let barButton = UIBarButtonItem(title: "Fechar", style: .plain, target: self, action: #selector(self.clickBack(_:)));
        let color = DeviceService().barButtonColor;
        
        if (!color.isEmpty) {
            barButton.tintColor = UIColor(hexString: color);
        }
        
        self.navigationItem.leftBarButtonItem = barButton;
        
        self.startLoad();
    }
    
    func initInfos() {
        let aps = self.userInfo.object(forKey: NotificationConstant.APS) as! NSDictionary;
        
        if let alert = aps.object(forKey: NotificationConstant.ALERT) as? NSDictionary {
            self.title = alert.object(forKey: NotificationConstant.TITLE) as? String;
        } else {
            self.title = userInfo.object(forKey: NotificationConstant.TITLE) as? String;
        }
        
        var url = "";
        
        if let urlScheme = self.userInfo.value(forKey: NotificationConstant.URL_SCHEME) as? String {
            url = urlScheme;
        } else if let idLogin = self.userInfo.value(forKey: NotificationConstant.ID_LOGIN) as? String {
            let urlTransactional = self.userInfo.value(forKey: NotificationConstant.URL_TRANSACTIONAL) as! String;
            let idSend = "\(self.userInfo.value(forKey: NotificationConstant.ID_SEND) ?? "")";
            let date = self.userInfo.value(forKey: NotificationConstant.DATE_NOTIFICATION) as? String;
            
            url = String(format: "%@/%@/%@/%@", locale: Locale.current, urlTransactional, date!, idLogin, idSend);
        } else if let idCampaign = self.userInfo.value(forKey: NotificationConstant.ID_CAMPAIGN) as? String {
            let urlCampaign = self.userInfo.value(forKey: NotificationConstant.URL_CAMPAIGN) as! String;
            let idPush = AlliNPush.getInstance().deviceToken.md5;
            
            url = String(format: "%@/%@/%@?type=mobile", locale: Locale.current, urlCampaign, idPush, idCampaign);
        }
        
        self.webView!.loadRequest(URLRequest(url: URL(string: url)!));
    }
    
    @objc func clickBack(_ send: UIBarButtonItem) {
        if (UIApplication.shared.isNetworkActivityIndicatorVisible) {
            return;
        }
        
        if (webView!.canGoBack) {
            webView!.goBack();
        } else {
            self.dismiss(animated: true, completion: nil);
        }
    }
    
    // MARK: WebView Methods
    func verifyURL(_ url: String) {
        if (!url.hasPrefix("http://") && !url.hasPrefix("https://")) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: url)!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: url)!);
            }
        }
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.startLoad();
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.stopLoad();
        
        let url = webView.request?.url?.absoluteString;
        
        self.navigationItem.leftBarButtonItem?.title = (url == "about:blank" ? "Fechar" : "Voltar");
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        self.verifyURL(request.url!.absoluteString);
        
        return true;
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.dismiss(animated: true, completion: nil);
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
