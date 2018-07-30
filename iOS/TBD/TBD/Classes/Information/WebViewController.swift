//
//  WebViewController.swift
//  TBD
//
//  Created by Stefan Olaru on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    open var webSiteURL: URL? = nil
    open var youtubeURL: String? = nil
    open var textHTML: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dismissButton.layer.cornerRadius = dismissButton.frame.size.width / 2
        let source = "document.body.style.background = \"#FFFFFF\";"
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentController = WKUserContentController()
        userContentController.addUserScript(userScript)
        webView.configuration.userContentController = userContentController
        webView.configuration.mediaTypesRequiringUserActionForPlayback = []
        webView.configuration.allowsInlineMediaPlayback = false
        webView.contentMode = .scaleAspectFit
        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadContent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadContent() {
        show(true)
        activityIndicator.startAnimating()
        if let url = webSiteURL {
            if url.isFileURL {
                //movie case
                webView.loadFileURL(url, allowingReadAccessTo: url)
            } else {
                let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
                webView.load(request)
            }
        } else if let url = youtubeURL {
            let embededHTML =
            """
            <html>
            <head>
            <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
            </head>
            <body style='margin:0; padding:0; height:100%; overflow:hidden;'>
            <script type='text/javascript' src='http://www.youtube.com/iframe_api'>
            </script>
            <script type='text/javascript'> function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}
            </script>
            <iframe id='playerId' type='text/html' width='100%' height='100%' src='http://www.youtube.com/embed/\(url)?enablejsapi=1&rel=0&playsinline=0&autoplay=1' frameborder='0'>
            </body>
            </html>
            """
            webView.loadHTMLString(embededHTML, baseURL: nil)
        } else if var text = textHTML {
            text = text.replacingOccurrences(of: "\n", with: "<br>")
            webView.loadHTMLString("""
                <html>
                <head>
                <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
                </head>
                <body>\(text)
                </body>
                </html>
                """, baseURL: nil)
        }
    }
    
    func show(_ isVisible: Bool) {
        activityIndicator.alpha = isVisible ? 1 : 0
    }
    
}

extension WebViewController: WKNavigationDelegate {
    
    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.alpha = 0
    }
}
