//
//  User.swift
//  Week06
//
//  Created by Keying Guo on 10/18/24.
//

import Foundation

struct User: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var age: Int
    var email: String
    var password: String
}
