//
//  ViewController.swift
//  Aviata
//
//  Created by Bakdaulet Myrzakerov on 10/3/20.
//

import UIKit
import SnapKit
import RealmSwift

final class MainPageViewController: LoaderBaseViewController {
    
    //MARK: - Proporties
    private var realm = try! Realm()    //to save articles, since there is no "save article API, I save it locally"
    private var tableView = UITableView()
    private var currentPage = 1
    private var pageSize = 15
    private var autoupdateTimeInterval : Double = 5
    private var viewModel = MainPageViewModel()
    private var parameters = Parameters()
    private var shouldKeepPagination = true
    private var category = "technology" //i made 2 variables on purpose, in case you want them to be different
    private var qInTitle = "technology"
    private var refreshControl = UIRefreshControl()
    private var endpointType : URLType = .topHeadlines {
        didSet {
            fullyUpdateTableView()
        }
    }
    private var timer : Timer!
    private var shouldAutoUpdate = true {
        didSet {
            shouldAutoUpdate ? startTimerForAutoUpdate() : timer.invalidate()
        }
    }
    private lazy var tabSwitcher = SwitcherView(firstTitle: category + " top", secondTitle: qInTitle + " all")
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateParameters()
        viewModel.getPost(with: parameters, urlType: endpointType)
        setupTableView()
        setupView()
        bind()
        startTimerForAutoUpdate()
        setupAction()
        setupLoaderView() // setups alerts
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Only update when staying on top and when first tab selected
        self.shouldAutoUpdate = (((tableView.safeAreaInsets.top + scrollView.contentOffset.y) == 0) && (endpointType == .topHeadlines))
    }
    
    //MARK:- binder
    private func bind(){
        viewModel.error.observe(on: self) { (error) in
            if error != "" {
            self.showErrorMessage(error)
            }
        }
        viewModel.loading.observe(on: self) { (loading) in
            loading ? self.showLoader() : self.hideLoader()
        }
        viewModel.articles.observe(on: self) { (articles) in
            self.tableView.reloadData()
            self.shouldKeepPagination = !(articles.count == 0)
        }
    }
    private func fullyUpdateTableView(){
        currentPage = 1
        updateParameters()
        viewModel.articles.value.removeAll()
        viewModel.getPost(with: parameters, urlType: endpointType)
    }
    //MARK:- Setup
    private func setupAction(){
        tabSwitcher.firstAction = { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.endpointType = .topHeadlines
        }
        tabSwitcher.secondAction = { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.shouldAutoUpdate = false
            strongSelf.endpointType = .everything
        }
        refreshControl.addTarget(self, action: #selector(swipeToRefresh), for: .valueChanged)
    }
    private func startTimerForAutoUpdate(){
        timer = Timer.scheduledTimer(withTimeInterval: autoupdateTimeInterval, repeats: true, block: { (timer) in
            guard self.shouldAutoUpdate else {
                timer.invalidate()
                return
            }
            self.currentPage = 1
            self.updateParameters()
            self.viewModel.getPost(with: self.parameters, urlType: self.endpointType, fromAutoUpdate: true)
        })
        
    }
    private func setupTableView(){
        tableView.refreshControl = refreshControl
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.cellIdentifier())
        tableView.separatorStyle = .none
        
    }
    private func setupView(){
        addSubview(tabSwitcher)
        tabSwitcher.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.right.equalTo(-10)
            make.left.equalTo(10)
            make.height.equalTo(40)
        }
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(tabSwitcher.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    private func updateParameters(){
        parameters.removeAll()
        parameters["page"] = currentPage
        parameters["pageSize"] = pageSize
        parameters["apiKey"] = AppConstants.API.APIKey
        if  endpointType == .topHeadlines {
            parameters["category"] = category
        }
        else {
            parameters["qInTitle"] = qInTitle
        }
    }
    @objc func swipeToRefresh(){
        fullyUpdateTableView()
        refreshControl.endRefreshing()
    }
}
//MARK: - EXTENSIONS
extension MainPageViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.cellIdentifier(), for: indexPath) as! ArticleTableViewCell
            cell.setupData(with: viewModel.articles.value[indexPath.row])
           
            let checkResult = realm.objects(SavedArticleModel.self).filter("linkToArticle == '\(viewModel.articles.value[indexPath.row].url ?? "")'").first
            cell.wasSaved = checkResult != nil
        
            cell.saveButtonAction = { [weak self] in
                guard let strongSelf = self else {
                    return}
                let savedArticle = SavedArticleModel()
                    savedArticle.linkToArticle = strongSelf.viewModel.articles.value[indexPath.row].url ?? ""
                    savedArticle.title = strongSelf.viewModel.articles.value[indexPath.row].title ?? ""
       
                try! strongSelf.realm.write {
                    let objectToDelete = strongSelf.realm.objects(SavedArticleModel.self).filter("linkToArticle == '\(strongSelf.viewModel.articles.value[indexPath.row].url ?? "")'").first
                    !cell.wasSaved  ? strongSelf.realm.add(savedArticle) : strongSelf.realm.delete(objectToDelete!)
                    
                    strongSelf.showSuccess()
                }
           
                cell.wasSaved.toggle()
                
            }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if  indexPath.row + 1 == viewModel.articles.value.count  && shouldKeepPagination{
            shouldKeepPagination = false
            currentPage += 1
            updateParameters()
            viewModel.getPost(with: parameters, urlType: endpointType)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.present(ArticleDetailViewController(postData: viewModel.articles.value[indexPath.row]).inNavigation(), animated: true, completion: nil)
    }
    
}
