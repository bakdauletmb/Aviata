//
//  PostDetailViewController.swift
//  Aviata
//
//  Created by Bakdaulet Myrzakerov on 10/4/20.
//

import UIKit

final class ArticleDetailViewController: LoaderBaseViewController{
    //MARK:- proporties
    private var postData : ArticleModel!
    private var imageView = UIImageView()
    private var titleView = HeaderAndTextView(header: "Title")
    private var authorView = HeaderAndTextView(header: "Author")
    private var descriptionView = HeaderAndTextView(header: "Description")
    private var contView = HeaderAndTextView(header: "ContentView")
    private var readMoreButton : UIButton = {
        var button = UIButton()
            button.setTitle("ReadMore", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    //MARK:- init
    init(postData : ArticleModel) {
        super.init(nibName: nil, bundle: nil)
        self.postData = postData
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        setupAction()
        setupNavBar()
    }
    //MARK:- setup
    private func setupAction(){
        readMoreButton.addTarget(self, action: #selector(readMoreTarget), for: .touchUpInside)
    }
    private func setupNavBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "x-button"), style: .plain, target: self, action: #selector(dismissAction))
    }

    private func setupView(){
        self.view.backgroundColor = .white
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        contentView.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.right.equalTo(-10)
        }
        contentView.addSubview(descriptionView)
        descriptionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom).offset(10)
            make.left.right.equalTo(titleView)
        }
        contentView.addSubview(authorView)
        authorView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionView.snp.bottom)
            make.left.right.equalTo(titleView)
        }
        contentView.addSubview(contView)
        contView.snp.makeConstraints { (make) in
            make.top.equalTo(authorView.snp.bottom)
            make.left.right.equalTo(titleView)
        }
        contentView.addSubview(readMoreButton)
        readMoreButton.snp.makeConstraints { (make) in
            make.top.equalTo(contView.snp.bottom).offset(10)
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-20)
        }
        
    }
    private func setupData(){
        imageView.sd_setImage(with: postData.urlToImage?.toURL, completed: nil)
        titleView.sectionValue.text = postData.title ?? ""
        authorView.sectionValue.text = postData.author ?? ""
        descriptionView.sectionValue.text = postData.description ?? ""
        contView.sectionValue.text = postData.content ?? ""
    }
    @objc func readMoreTarget(){
        if let url = postData.url?.toURL {
            self.navigationController?.pushViewController(ReadMoreViewController(url: url), animated: true)
        }
    }
    
    
}
