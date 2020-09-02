//
//  CDUser+CoreDataClass.swift
//  Repository
//
//  Created by alpiopio on 01/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CDUser)
public class CDUser: NSManagedObject {
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
