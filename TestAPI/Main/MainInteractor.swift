//
//  MainInteractor.swift
//  TestAPI
//
//  Created by Никита on 19/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import Foundation

protocol MainInteractorInputProtocol: class {
    func fetchPosts()
    func getSession()
    var presenter: MainInteractorOutputProtocol? { get set }
}

final class MainInteractor: MainInteractorInputProtocol {
    weak var presenter: MainInteractorOutputProtocol?

    func getSession() {
        if UserDefaults.session == nil {
            Service().getSession { newSession, error in
                if error == nil {
                    guard let session = newSession else { return }
                    let defaults = UserDefaults.standard
                    defaults.setValue(session, forKey: "session")
                    self.presenter?.ddRetriveSession()
                } else {
                    self.presenter?.sessionError()
                }
            }
        }
    }

    func fetchPosts() {
        Service().getPosts { posts, error in
            if error == nil {
                self.presenter?.didRetrievePosts(posts)
            } else {
                self.presenter?.onError()
            }
        }
    }
}




