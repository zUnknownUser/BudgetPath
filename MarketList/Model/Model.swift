//
//  Model.swift
//  MarketList
//
//  Created by Lucas Amorim on 24/01/25.
//

import Foundation

struct Login: Codable {
    var email: String
    var password: String
    var name: String
}

struct LoginResponse: Codable {
    var id: String
    var name: String
    var email: String
    var createdAt: String
    var token: String?
}
