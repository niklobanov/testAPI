//
//  PostTableViewCell.swift
//  TestAPI
//
//  Created by Никита on 13/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var dateModificatedLabel: UILabel!
    @IBOutlet weak var postText: UITextView! 
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postText.isEditable = false
    }
    
    func set(forPost post: PostModel) {
        dateCreatedLabel.text = "da : " + post.da
        if post.da == post.dm {
            dateModificatedLabel.text = ""
        } else {
            dateModificatedLabel.text = "dm :" + post.dm
        }
        let text = post.body[0..<200]
        postText.text = text
    }
    
}

