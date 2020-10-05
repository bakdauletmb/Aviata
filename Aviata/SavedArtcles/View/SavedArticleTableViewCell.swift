//
//  SavedArticleTableViewCell.swift
//  Aviata
//
//  Created by Bakdaulet Myrzakerov on 10/4/20.
//

import UIKit

final class SavedArticleTableViewCell: UITableViewCell {
    //MARK: - variables
    private var titleLabel : UILabel = {
        var title = UILabel()
            title.font = .monospacedDigitSystemFont(ofSize: 16, weight: .heavy)
            title.numberOfLines = 0
        
        return title
    }()
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: setupView
    private func setupView(){
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.bottom.right.equalTo(-10)
        }
    }
    public func setupData(title : String){
        self.titleLabel.text = title
    }
    
}
