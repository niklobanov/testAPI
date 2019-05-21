//
//  PostDetailPresenter.swift
//  TestAPI
//
//  Created by Никита on 20/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import Foundation

protocol PostDetailPresenterProtocol: class {
    var post: PostModel? { get set }
    var view: PostDetailViewProtocol? { get set }
    var wireFrame: PostDetailWireFrameProtocol? { get set }
    func viewDidLoad()
}

final class PostDetailPresenter: PostDetailPresenterProtocol {
    var view: PostDetailViewProtocol?
    var post: PostModel?
    var wireFrame: PostDetailWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showPostDetail(forPost: post!)
    }
    
}
