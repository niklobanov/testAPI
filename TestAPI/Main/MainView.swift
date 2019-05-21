//
//  MainViewController.swift
//  TestAPI
//
//  Created by Никита on 12/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import UIKit
import PKHUD

protocol MainViewProtocol: class {
    var presenter: MainPresenterProtocol? { get set }
    func showLoading()
    func showPosts(with posts: [PostModel])
    func connectError()
    func hideLoading()
    func sessionError()
}


final class MainView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var postList = [PostModel]()
    var presenter: MainPresenterProtocol?

    @objc
    func addPost() {
        presenter?.addPost()
    }

    override func viewDidLoad() {

        setUpNavigationItem()
        NotificationCenter.default.addObserver(
        forName: NSNotification.Name.newPost,
        object: nil,
        queue: nil
        ) { _ in
            self.presenter?.viewDidLoad()
        }
        presenter?.getSession()
        presenter?.viewDidLoad()
    }


    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }

    func setUpNavigationItem() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPost))
        navigationItem.setRightBarButton(addButton, animated: true)
        tableView.tableFooterView = UIView()
    }
}

extension MainView: MainViewProtocol  {

    func sessionError() {
        refreshSession()
    }

    func showPosts(with posts: [PostModel]) {
        postList = posts
        tableView.reloadData()
    }

    func connectError() {
        refreshData()
    }

    func showLoading() {
        HUD.show(.progress)
    }

    func hideLoading() {
        HUD.hide()
    }

    func refreshData() {
        let allert = UIAlertController(title: "Internet not connected", message: "Refresh?", preferredStyle: .alert)
        let allertActionYes = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            self?.viewDidLoad()
        }
        let allertCancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        allert.addAction(allertCancel)
        allert.addAction(allertActionYes)
        present(allert, animated: true)
    }

    func refreshSession() {
        let allert = UIAlertController(title: "Unspecified field session", message: "Try again?", preferredStyle: .alert)
        let allertActionYes = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            self?.viewDidLoad()
        }
        let allertCancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        allert.addAction(allertCancel)
        allert.addAction(allertActionYes)
        present(allert, animated: true)
    }
}


extension MainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        let post = postList[indexPath.row]
        cell.set(forPost: post)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showDetailsForPost(post: postList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

