//
//  Label.swift
//  Aviata
//
//  Created by Bakdaulet Myrzakerov on 10/4/20.
//

import UIKit
enum LabelType {
    case header
    case content
}
final class HeaderAndTextView : UIView {
    //MARK: - Proporties
    private var headerLabel : UILabel = {
        var label = UILabel()
            label.font = .monospacedSystemFont(ofSize: 16, weight: .bold)
            label.numberOfLines = 0
        
        return label
    }()
    public var sectionValue : UILabel = {
        var label = UILabel()
            label.font = .monospacedDigitSystemFont(ofSize: 12, weight: .light)
            label.numberOfLines = 0
        
        return label
    }()
    
    //MARK: - Init
    init(header : String) {
        super.init(frame: .zero)
        self.headerLabel.text = header
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- SetUpView
    private func setupView(){
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.right.equalTo(-10)
        }
        addSubview(sectionValue)
        sectionValue.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-2)
        }
    }
    
}
