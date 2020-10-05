//
//  SwitcherView.swift
//  Flat
//
//  Created by Bakdaulet Myrzakerov on 4/30/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

class SwitcherView: UIView {
    
    //MARK: - Properties
    var firstAction: (() -> ())?
    var secondAction: (() -> ())?
    
    var selectedButton: UIButton? {
        didSet{
            let buttons = [firstButton, secondButton]
            for button in buttons {
                button.setTitleColor(.black, for: .normal)
            }
            self.selectedButton!.setTitleColor(.gray, for: .normal)
            
        }
    }
    lazy var firstButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 15, weight: .black)
        
        return button
    }()
    lazy var secondButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 15, weight: .black)

        return button
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        
        return view
    }()
    
    //MARK: - Initialization
    init(firstTitle: String, secondTitle: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = .clear
        firstButton.setTitle(firstTitle, for: .normal)
        secondButton.setTitle(secondTitle, for: .normal)
        setupView()
        setupAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup function
    private func setupView() -> Void {
        addSubview(firstButton)
        firstButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(snp.centerX)
        }
        addSubview(secondButton)
        secondButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(snp.centerX)
        }
        
        addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.centerX.equalTo(firstButton)
            make.height.equalTo(2.5)
            make.bottom.equalToSuperview()
        }
        
    }
    
    private func setupAction() -> Void {
        firstButton.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(buttonPressed(sender: )), for: .touchUpInside)
    }
    
//    MARK: - Simple functions
    func firstButtonSelected() -> Void {
        selectedButton = firstButton
        UIView.animate(withDuration: 0.3) {
            self.bottomView.snp.remakeConstraints { (make) in
                make.left.right.centerX.equalTo(self.firstButton)
                make.height.equalTo(2)
                make.bottom.equalToSuperview()

            }
            self.superview?.layoutIfNeeded()
        }
        firstAction?()
    }
    
    func secondButtonSelected() -> Void {
        selectedButton = secondButton
        UIView.animate(withDuration: 0.3) {
            self.bottomView.snp.remakeConstraints { (make) in
                make.left.right.centerX.equalTo(self.secondButton)
                make.height.equalTo(2)
                make.bottom.equalToSuperview()

            }
            self.superview?.layoutIfNeeded()
        }
        secondAction?()

    }
    
    //MARK: - Objective function
    @objc func buttonPressed(sender: UIButton) -> Void {
        if selectedButton != sender {
            if sender == firstButton {
                firstButtonSelected()
            } else {
                secondButtonSelected()
            }
        }
    }
    
}
