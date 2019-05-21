
//
//  File.swift
//  TestAPI
//
//  Created by Никита on 19/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import UIKit

protocol MainWireFrameProtocol {
    func presentAddPostScreen(from view: MainViewProtocol)
    func presentPostDetailScreen(from view: MainViewProtocol, forPost post: PostModel)
    static func createPostListModule() -> UIViewController
}

final class MainWireFrame: MainWireFrameProtocol {
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    class func createPostListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "PostsNavigationController")
        if let view = navController.children.first as? MainView {
            let presenter: MainPresenterProtocol & MainInteractorOutputProtocol = MainPresenter()
            let interactor: MainInteractorInputProtocol  = MainInteractor()
            let wireFrame: MainWireFrameProtocol = MainWireFrame()
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            return navController
        }
        return UIViewController()
    }

    func presentPostDetailScreen(from view: MainViewProtocol, forPost post: PostModel)  {
        let postDetailViewController = PostDetailWireFrame.createPostDetailModule(forPost: post)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(postDetailViewController, animated: true)
        }
    }

    func presentAddPostScreen(from view: MainViewProtocol) {
        let addPostViewController = AddPostWireFrame.createPostListModule()
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(addPostViewController, animated: true)
        }
    }

}
