//
//  ArticleTableViewCell.swift
//  Aviata
//
//  Created by Bakdaulet Myrzakerov on 10/3/20.
//

import UIKit

final class ArticleTableViewCell: UITableViewCell {
    //MARK: - proporties
    private var articleImageView : UIImageView = {
        var image = UIImageView()
            image.clipsToBounds = true
            image.contentMode = .scaleAspectFit
            image.layer.cornerRadius = 10
        
        return image
    }()
    public var wasSaved : Bool = false {
        didSet{
            wasSaved ? saveArticleButton.setTitle("RemoveMe", for: .normal) : saveArticleButton.setTitle("SaveMe", for: .normal)
        }
    }
    private var articleNameLabel : UILabel =  {
        var label = UILabel()
            label.font = .monospacedDigitSystemFont(ofSize: 14, weight: .black)
            label.numberOfLines = 0
        
        return label
    }()
    public var saveButtonAction = {()->() in}
    private var saveArticleButton : UIButton =  {
        var button = UIButton()
            button.setTitle("SaveMe", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            
        return button
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setUpAction()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- Setup
    private func setUpAction(){
        saveArticleButton.addTarget(self, action: #selector(didTapSaveButtonTarget), for: .touchUpInside)
    }
    
    private func setupView(){
        selectionStyle = .none
        contentView.addSubview(articleImageView)
        articleImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.left.equalTo(10)
            make.top.equalToSuperview()
            make.height.equalTo(200)
            
        }
        contentView.addSubview(saveArticleButton)
        saveArticleButton.snp.makeConstraints { (make) in
            make.top.equalTo(articleImageView.snp.bottom).offset(4)
            make.width.height.equalTo(90)
            make.right.equalTo(articleImageView)
            make.bottom.equalTo(-10)
        }
        contentView.addSubview(articleNameLabel)
        articleNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(saveArticleButton)
            make.left.equalTo(articleImageView)
            make.right.equalTo(saveArticleButton.snp.left).offset(-10)
            make.bottom.equalTo(-10)
        }
        
    }
    
    public func setupData(with article : ArticleModel){
        articleNameLabel.text = article.title
        if let url = article.urlToImage {
            articleImageView.sd_setImage(with: url.toURL, completed: nil)
        }
        
    }
    
    @objc func didTapSaveButtonTarget(){
        saveButtonAction()
    }
    
}
