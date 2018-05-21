//
//  ProjectDetailsViewController.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 19/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation
import WebKit
import SVProgressHUD

class ProjectDetailsViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    public var projectInfo: BlcokchainProjectInfo?
    
    @IBOutlet weak var projectDetailsWebview: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        projectDetailsWebview.isHidden = true
        SVProgressHUD.show()
    }

    private func setupWebView() {
        projectDetailsWebview.uiDelegate = self
        projectDetailsWebview.navigationDelegate = self

        let url = URL(string: (projectInfo?.detailsLink)!)

        let request = URLRequest(url: url!)

        projectDetailsWebview.load(request)
        self.projectDetailsWebview.isHidden = true
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
                self.projectDetailsWebview.isHidden = false
                self.setupNavagationBar()
                self.projectDetailsWebview.isHidden = false
            })
        }
    }

    func setupNavagationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = projectInfo?.title
    }
}
