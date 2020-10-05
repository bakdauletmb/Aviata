//
//  SavedArtcilesViewController.swift
//  Aviata
//
//  Created by Bakdaulet Myrzakerov on 10/3/20.
//

import UIKit
import RealmSwift
import Realm

final class SavedArtcilesViewController: UIViewController {
    //MARK:- proporties
    private var tableView = UITableView()
    private let realm = try! Realm()
    private var notificationLabel : UILabel = {
        var label = UILabel()
            label.text = "Press SaveMe on post you like"
            label.font = .monospacedDigitSystemFont(ofSize: 14, weight: .semibold)
            label.textAlignment = .center
        
        return label
    }()
    //MARK:- lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
    }
    
    //MARK:- setup
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SavedArticleTableViewCell.self, forCellReuseIdentifier: SavedArticleTableViewCell.cellIdentifier())
    }
    private func setupView(){
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        addSubview(notificationLabel)
        notificationLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}

extension SavedArtcilesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.isHidden = realm.objects(SavedArticleModel.self).count == 0
        notificationLabel.isHidden = !tableView.isHidden
        return realm.objects(SavedArticleModel.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedArticleTableViewCell.cellIdentifier(), for: indexPath) as! SavedArticleTableViewCell
            cell.setupData(title: realm.objects(SavedArticleModel.self)[indexPath.row].title)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.present(ReadMoreViewController(url: realm.objects(SavedArticleModel.self)[indexPath.row].linkToArticle.toURL), animated: true, completion: nil)

    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeElement = self.realm.objects(SavedArticleModel.self)[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] (_, _, _) in
            try! self.realm.write {
                self.realm.delete(removeElement)
                tableView.reloadData()
            }
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
