//
//  AddPostInteractor.swift
//  TestAPI
//
//  Created by Никита on 20/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import Foundation
import UIKit

extension NSNotification.Name {
    static let newPost = NSNotification.Name("newPost")
}

protocol AddPostInteractorInputProtocol: class {
    func savePost(with text: String)
}


final class AddPostInteractor: AddPostInteractorInputProtocol {
    func savePost(with text: String) {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "session") != nil {
            Service().addEntry(text: text)
            NotificationCenter.default.post(name: NSNotification.Name.newPost, object: nil)
        }
    }
}
