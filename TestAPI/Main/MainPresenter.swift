//
//  MainPresenter.swift
//  TestAPI
//
//  Created by Никита on 19/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import Foundation


protocol MainPresenterProtocol: class {
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorInputProtocol? { get set }
    var wireFrame: MainWireFrameProtocol? { get set }
    func viewDidLoad()
    func getSession()
    func showDetailsForPost(post: PostModel)
    func addPost()
}

protocol MainInteractorOutputProtocol: class {
    func didRetrievePosts(_ posts: [PostModel])
    func onError()
    func sessionError()
    func ddRetriveSession()
}


final class MainPresenter: MainPresenterProtocol {

    weak var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    var wireFrame: MainWireFrameProtocol?

    func viewDidLoad() {
        view?.showLoading()
        interactor?.fetchPosts()
    }

    func getSession() {
        view?.showLoading()
        interactor?.getSession()
    }

    func showDetailsForPost(post: PostModel) {
        wireFrame?.presentPostDetailScreen(from: view!, forPost: post)
    }

    func addPost() {
        wireFrame?.presentAddPostScreen(from: view!)
    }

}

extension MainPresenter: MainInteractorOutputProtocol {
    func ddRetriveSession() {
        view?.hideLoading()
    }

    func sessionError() {
        view?.hideLoading()
        view?.sessionError()
    }

    func didRetrievePosts(_ posts: [PostModel]) {
        view?.hideLoading()
        view?.showPosts(with: posts)
    }

    func onError() {
        view?.hideLoading()
        view?.connectError()
    }

}
