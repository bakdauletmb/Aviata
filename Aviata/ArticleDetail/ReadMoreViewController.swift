//
//  ReadMoreViewController.swift
//  Aviata
//
//  Created by Bakdaulet Myrzakerov on 10/4/20.
//

import UIKit
import WebKit
final class ReadMoreViewController: LoaderBaseViewController {
    //MARK:- Proporties
    private var url : URL!
    private var webView = WKWebView()
    
    //MARK:- init
    init(url : URL) {
    super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLoaderView()
        setupWebView()
    }
    
    //MARK:- setup
    private func setupView(){
        addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    private func setupWebView(){
        webView.load(URLRequest(url: url!))
    }
    
}
