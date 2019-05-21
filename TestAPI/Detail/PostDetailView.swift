//
//  PostDetailView.swift
//  TestAPI
//
//  Created by Никита on 20/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import UIKit

protocol PostDetailViewProtocol: class {
    var presenter: PostDetailPresenterProtocol? { get set }
    func showPostDetail(forPost post: PostModel)
}

final class PostDetailView: UIViewController {
    @IBOutlet weak var dataModificatedLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dataCreatedLabel: UILabel!
    @IBOutlet weak var textView: UITextView!

    var presenter: PostDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
        presenter?.viewDidLoad()
    }
}

extension PostDetailView: PostDetailViewProtocol {
    func showPostDetail(forPost post: PostModel) {
        idLabel.text = "Id: " + post.id
        dataModificatedLabel.text = "Дата редактирования: " + post.dm
        dataCreatedLabel.text = "Дата создания: " + post.da
        textView.text = post.body
    }

}
