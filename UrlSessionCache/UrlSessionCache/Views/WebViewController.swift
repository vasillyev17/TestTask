//
//  WebViewController.swift
//  NewsApp
//
//  Created by ihor on 06.11.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var links: String
    var webView = WKWebView()
    
    init(links: String) {
        self.links = links
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: links) else { return }
        self.webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
}

extension WebViewController: WKNavigationDelegate {}

