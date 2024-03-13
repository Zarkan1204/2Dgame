//
//  UserModel.swift
//  2Dgame
//
//  Created by Мой Macbook on 19.02.2024.
//

import UIKit

struct User: Codable {
    var name: String
    var score: Int = 0 
    var avatar: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case name, score
    }
}
