//
//  CDUser+extension.swift
//  Repository
//
//  Created by alpiopio on 03/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation

extension CDUser {
    func convertToUser() -> UserModel {
        return UserModel(id: id,
                         name: name,
                         phone: phone,
                         email: email,
                         birthDate: birthDate,
                         gender: gender,
                         profile: profile)
    }
}
