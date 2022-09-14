//
//  Post.swift
//  Navigation
//
//  Created by Dima Gorbachev on 02.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

public struct Post {
    public let title: String
    public init(title: String) {
        self.title = title
    }
}

public struct PostData {
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    
    public init(author: String, description: String, image: String, likes: Int, views: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
}

public var posts = [PostData(author: "Netflix", description: "Netflix скоро заговорит по-русски! Будет доступен на русском языке!", image: "netflix", likes: 45, views: 230),
             PostData(author: "Mobile review", description: "Музыкальный стриминговый сервис Spotify официально пришел в Россию", image: "spotify", likes: 31, views: 181),
             PostData(author: "Игромания", description: "Недавно Epic Games включила S.T.A.L.K.E.R. 2 в список готовящихся игр, которые создаются на базе движка компании — Unreal Engine 4. Слухи об этом ходили с самого анонса, однако до текущего момента определённости в вопросе не было.", image: "stalker", likes: 58, views: 227),
             PostData(author: "Meduza", description: "Теперь почти официально: Россия на первом месте по числу жертв коронавируса на душу населения. Это результат действий властей летом 2020 года", image: "corona", likes: 46, views: 312)]
