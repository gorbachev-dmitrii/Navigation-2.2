//
//  Post.swift
//  Navigation
//
//  Created by Dima Gorbachev on 02.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct PostData {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
}

var posts = [PostData(author: "author 1", description: "desc 1", image: "", likes: 5, views: 5),
             PostData(author: "author 2", description: "desc 2", image: "", likes: 5, views: 5),
             PostData(author: "author 3", description: "desc 3", image: "", likes: 5, views: 5),
             PostData(author: "author 4", description: "desc 4", image: "", likes: 5, views: 5)]
