

import Foundation
import UIKit


class ScrollViewController: UIViewController {
    
    //MARK: - Properties
    lazy var scrollView = UIScrollView()
    lazy var contentView: UIView = {
        let view = UIView()

        return view
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: - Setup functions
    func setupScrollView() {
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.keyboardDismissMode = .onDrag
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(AppConstants.statusBarHeight)
            make.width.equalTo(AppConstants.screenWidth)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }
    }
    
    //MARK: - Simple functions
    func addToScrollView(_ views: [UIView]) -> Void {
        for view in views {
            scrollView.addSubview(view)
        }
    }
}
