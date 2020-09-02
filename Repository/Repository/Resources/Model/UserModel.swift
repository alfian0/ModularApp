//
//  UserModel.swift
//  Repository
//
//  Created by alpiopio on 01/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation

public struct UserModel {
    public let id: String?
    public let name: String?
    public let phone: String?
    public let email: String?
    public let birthDate: Date?
    public let gender: String?
    public let profile: String?
    
    public init(id: String?, name: String?, phone: String?, email: String?, birthDate: Date?, gender: String?, profile: String?) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.birthDate = birthDate
        self.gender = gender
        self.profile = profile
    }
}
