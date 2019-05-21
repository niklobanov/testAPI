//
//  File.swift
//  TestAPI
//
//  Created by Никита on 19/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import UIKit

protocol PostDetailWireFrameProtocol: class {
    static func createPostDetailModule(forPost post: PostModel) -> UIViewController
}

final class PostDetailWireFrame: PostDetailWireFrameProtocol {
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    class func createPostDetailModule(forPost post: PostModel) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "PostDetailController")
        if let view = viewController as? PostDetailView {
            let presenter: PostDetailPresenterProtocol = PostDetailPresenter()
            let wireFrame: PostDetailWireFrameProtocol = PostDetailWireFrame()
            view.presenter = presenter
            presenter.view = view
            presenter.post = post
            presenter.wireFrame = wireFrame
            viewController.title = "Просмотр записи"
            return viewController
        }
        return UIViewController()
    }

}
