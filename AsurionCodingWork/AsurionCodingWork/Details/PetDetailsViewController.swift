//
//  PetDetailsViewController.swift
//  AsurionCodingWork
//
//  Created by Gaurav Jindal on 02/08/22.
//

import UIKit
import WebKit

class PetDetailsViewController: UIViewController, WKNavigationDelegate {

    private let webView = WKWebView()
    var contentUrl: String?
    private var progressView: UIProgressView?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: contentUrl ?? "") {
            webView.navigationDelegate = self
           setProgressViewProperties()
            webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
            webView.load(URLRequest(url: url))
        }
    }
    
    override func loadView() {
        self.view = webView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView?.progress = Float(webView.estimatedProgress)
        }
    }
    
    func setProgressViewProperties() {
        progressView = UIProgressView(progressViewStyle: .default)
        progressView?.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView ?? UIProgressView())
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }
}
