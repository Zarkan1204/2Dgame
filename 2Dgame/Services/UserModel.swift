//
//  UserModel.swift
//  2Dgame
//
//  Created by Мой Macbook on 19.02.2024.
//

import UIKit

struct User {
    var name: String
    var score: Int = 0
    var avatar: UIImage?
    
    static func makeModel() -> [User] {
        var userModel = [User]()
        userModel.append(User(name: "artem", score: 5, avatar: UIImage(named: "redCar")))
        userModel.append(User(name: "sdgsg", score: 10, avatar: UIImage(named: "redCar")))
        userModel.append(User(name: "qwerty", score: 15, avatar: UIImage(named: "redCar")))
        
        return userModel
    }
}
