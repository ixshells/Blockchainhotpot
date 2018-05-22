//
//  KnowledgebaseDetailsViewController.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 02/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import SafariServices
import SVProgressHUD

class KnowledgebaseDetailsViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    public var knowledgeInfo: KnowledgeInfo?

    @IBOutlet weak var knowledegeDetailsWebview: WKWebView!

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        knowledegeDetailsWebview.isHidden = true
        SVProgressHUD.show()
    }

    private func setupWebView() {
        knowledegeDetailsWebview.uiDelegate = self
        knowledegeDetailsWebview.navigationDelegate = self

        let url = URL(string: (knowledgeInfo?.detailsUrl)!)

        let request = URLRequest(url: url!)

        knowledegeDetailsWebview.load(request)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }

        switch navigationAction.navigationType {
        case .linkActivated:
            UIApplication.shared.open( navigationAction.request.url!, options: [:], completionHandler: nil)
        default:
            break
        }

        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if !webView.isLoading {
            let jsCode = "document.getElementsByClassName('article-info')[0].style.display = 'none';" +
            "document.getElementsByClassName('header-wrap')[0].style.display = 'none';" +
            "document.getElementsByClassName('article-footer')[0].style.display = 'none';" +
            "document.getElementsByClassName('user-panel')[0].style.display = 'none';" +
            "let lazyShim = document.getElementsByClassName('v-lazy-shim');for (var i=0;i<lazyShim.length;i++){lazyShim[i].style.display = 'none';}" +
            "document.getElementById('footer').style.display = 'none';";

            webView.evaluateJavaScript(jsCode, completionHandler: { (_, _) in
                SVProgressHUD.dismiss()
                self.knowledegeDetailsWebview.isHidden = false
                self.setupNavagationBar()
            })
        }
    }

    func setupNavagationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = knowledgeInfo?.title
    }

}

