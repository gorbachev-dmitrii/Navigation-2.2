//
//  Post.swift
//  Navigation
//
//  Created by Dima Gorbachev on 22.06.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

class Post: Object {
    @Persisted var author: String = ""
    @Persisted var content: String = ""
    @Persisted var image: String = ""
    @Persisted var likes: Int
    @Persisted var isSaved: Bool
    @Persisted var isLiked: Bool
    
    convenience init(author: String, content: String, image: String, likes: Int, isSaved: Bool, isLiked: Bool) {
        self.init()
        self.author = author
        self.content = content
        self.image = image
        self.likes = likes
        self.isSaved = isSaved
        self.isLiked = isLiked
    }
}

