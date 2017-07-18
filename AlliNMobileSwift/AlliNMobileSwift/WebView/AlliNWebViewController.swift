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
    
    
    // MARK: animêixon ProgressBar
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
        self.webView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight];
        self.webView!.delegate = self;
        
        self.progressBar = UIActivityIndicatorView(activityIndicatorStyle: .gray);
        self.progressBar!.center = self.view.center;
        
        self.view.addSubview(self.webView!);
        self.view.addSubview(self.progressBar!);
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Fechar", style: .plain, target: self, action: #selector(self.clickBack(_:)));
    }
    
    func initInfos() {
        let aps = self.userInfo.object(forKey: NotificationConstant.APS) as! NSDictionary;
        
        if let alert = aps.object(forKey: NotificationConstant.ALERT) as? NSDictionary {
            self.title = alert.object(forKey: NotificationConstant.TITLE) as? String;
        } else {
            self.title = userInfo.object(forKey: NotificationConstant.TITLE) as? String;
        }
        
        if var urlScheme = self.userInfo.value(forKey: NotificationConstant.URL_SCHEME) as? String {
            if (urlScheme.characters.count > 0) {
                urlScheme = urlScheme.removingPercentEncoding!;
                urlScheme = urlScheme.replacingOccurrences(of: "##id_push##", with: AlliNPush.getInstance().deviceToken.md5);
                
                self.webView!.loadRequest(URLRequest(url: URL(string: urlScheme)!));
            } else {
                self.load(self.userInfo);
            }
        } else if let idLogin = self.userInfo.value(forKey: NotificationConstant.ID_LOGIN) as? String {
            if (idLogin.characters.count > 0) {
                let urlTransactional = self.userInfo.value(forKey: NotificationConstant.URL_TRANSACTIONAL) as? String;
                let idSend = "\(self.userInfo.value(forKey: NotificationConstant.ID_SEND) ?? "")";
                let date = self.userInfo.value(forKey: NotificationConstant.DATE_NOTIFICATION) as? String;
                let url = String(format: "%@/%@/%@/%@", locale: Locale.current, urlTransactional!, date!, idLogin, idSend);
                
                self.webView!.loadRequest(URLRequest(url: URL(string: url)!));
            } else {
                self.load(self.userInfo);
            }
        } else {
            self.load(self.userInfo);
        }
    }
    
    func clickBack(_ send: UIBarButtonItem) {
        if (UIApplication.shared.isNetworkActivityIndicatorVisible) {
            return;
        }
        
        if (webView!.canGoBack) {
            webView!.goBack();
        } else if (self.navigationItem.leftBarButtonItem?.title == "Voltar") {
            self.loadWebView(self.html);
        } else {
            self.dismiss(animated: true, completion: nil);
        }
    }
    
    func load(_ value: NSDictionary) {
        AlliNPush.getInstance().getCampaignHTML(id: value.object(forKey: NotificationConstant.ID_CAMPAIGN) as! Int) { (htmlAny, httpRequestError) in
            if let _ = httpRequestError {
                self.load(value);
            }
            
            var html: String = htmlAny as! String;
            
            html = html.replacingOccurrences(of: "##id_push##", with: AlliNPush.getInstance().deviceToken.md5);
            
            self.loadWebView(html);
        }
    }
    
    // MARK: WebView Methods
    func loadWebView(_ html: String) {
        self.html = html;
        
        self.webView!.loadHTMLString(html, baseURL: nil);
    }
    
    func verifyURL(_ url: String) {
        if (!url.hasPrefix("http://") && !url.hasPrefix("https://")) {
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil);
        }
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.startLoad();
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.stopLoad();
        
        let url = webView.request?.url?.absoluteString;
        
        self.navigationItem.leftBarButtonItem?.title = url == "about:blank" ? "Voltar" : "Fechar";
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        self.verifyURL(request.url!.absoluteString);
        
        return true;
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.dismiss(animated: true, completion: nil);
    }
}
