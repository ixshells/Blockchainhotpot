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

class KnowledgebaseDetailsViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    public var knowledgebaseDetails: KnowledgebaseDetails?

    @IBOutlet weak var knowledegeDetailsWebview: WKWebView!

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        activityIndicatorView.backgroundColor = UIColor.gray
    
        activityIndicatorView.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setupWebView() {
        knowledegeDetailsWebview.uiDelegate = self
        knowledegeDetailsWebview.navigationDelegate = self

        let url = URL(string: (knowledgebaseDetails?.detalsUrl)!)

        let request = URLRequest(url: url!)

        knowledegeDetailsWebview.load(request)

//        let url = Bundle.main.url(forResource: "Knowledege", withExtension: "html")


//        knowledegeDetailsWebview.loadFileURL(url!, allowingReadAccessTo: Bundle.main.bundleURL)
//        knowledegeDetailsWebview.load(<#T##data: Data##Data#>, mimeType: <#T##String#>, characterEncodingName: <#T##String#>, baseURL: <#T##URL#>)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if !webView.isLoading {
            webView.evaluateJavaScript("document.readyState", completionHandler: { (_, _) in
                self.activityIndicatorView.stopAnimating()
            })
        }
    }

}

