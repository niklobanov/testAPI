//
//  AddPostView.swift
//  TestAPI
//
//  Created by Никита on 20/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import UIKit

protocol AddPostViewProtocol: class {
    var presenter: AddPostPresenterProtocol? { get set }
    func setNavigationButton()
}

final class AddPostView: UIViewController, AddPostViewProtocol {
    var presenter: AddPostPresenterProtocol?
    @IBOutlet weak var textView: UITextView!

    @objc
    func savePost() {
        if let text = textView.text {
            if !text.isEmpty {
                presenter?.savePost(with: text)
                navigationController?.popViewController(animated: true)
            } else {
                showAllert()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationButton()
    }

    func setNavigationButton() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePost))
        navigationItem.setRightBarButton(saveButton, animated: true)
    }

    func showAllert() {
        let allert = UIAlertController(title: "Ошибка", message: "Пожалуйста, введите текст для отправки", preferredStyle: .alert)
        let allertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        allert.addAction(allertAction)
        present(allert, animated: true)
    }
}

