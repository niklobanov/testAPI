//
//  AddPostWireFrame.swift
//  TestAPI
//
//  Created by Никита on 20/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import UIKit

protocol AddPostWireFrameProtocol: class {
    static func createPostListModule() -> UIViewController
}

final class AddPostWireFrame: AddPostWireFrameProtocol {
    static func createPostListModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "AddPostViewController")
        if let view = viewController as? AddPostView {
            let presenter: AddPostPresenterProtocol = AddPostPresenter()
            let wireFrame: AddPostWireFrameProtocol = AddPostWireFrame()
            let interactor: AddPostInteractorInputProtocol = AddPostInteractor()
            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame
            viewController.title = "Добавить запись"
            return viewController
        }
        return UIViewController()
    }

    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
