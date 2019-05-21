//
//  AddPostPresenter.swift
//  TestAPI
//
//  Created by Никита on 20/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import Foundation

protocol AddPostPresenterProtocol: class {
    var view: AddPostViewProtocol? { get set }
    var wireFrame: AddPostWireFrameProtocol? { get set }
    var interactor: AddPostInteractorInputProtocol? { get set }
    func savePost(with text: String)
}

final class AddPostPresenter: AddPostPresenterProtocol {
    var view: AddPostViewProtocol?
    var wireFrame: AddPostWireFrameProtocol?
    var interactor: AddPostInteractorInputProtocol?

    func savePost(with text: String) {
        interactor?.savePost(with: text)
    }
}


