//
//  UserDataRepository.swift
//  UserModule
//
//  Created by alpiopio on 31/08/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation
import CoreData

public protocol IDataRepository {
    associatedtype T
    
    func create(user: T)
    func getAll() -> [T]?
    func get(byIdentifier id: String) -> T?
    func update(user: T) -> Bool
    func delete(id: String) -> Bool
}

public struct UserDataRepository: IDataRepository {
    public init() {}
    
    public func create(user: UserModel) {
        let cd_user = CDUser(context: PersistentStorage.shared.persistentContainer.viewContext)
        cd_user.id = user.id
        cd_user.name = user.name
        cd_user.phone = user.phone
        cd_user.email = user.email
        cd_user.gender = user.gender
        cd_user.birthDate = user.birthDate
        cd_user.profile = user.profile
        PersistentStorage.shared.saveContext()
    }
    
    public func getAll() -> [UserModel]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDUser.self)

        var users : [UserModel] = []

        result?.forEach({ (user) in
            users.append(user.convertToUser())
        })

        return users
    }
    
    public func get(byIdentifier id: String) -> UserModel? {
        let result = getCDUser(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.convertToUser()
    }
    
    public func update(user: UserModel) -> Bool {
        guard let id = user.id else { return false }
        let cdUser = getCDUser(byIdentifier: id)
        guard cdUser != nil else {return false}
        cdUser?.email = user.email
        cdUser?.name = user.name
        cdUser?.profile = user.profile
        PersistentStorage.shared.saveContext()
        return true
    }
    
    public func delete(id: String) -> Bool {
        let cdUser = getCDUser(byIdentifier: id)
        guard cdUser != nil else {return false}
        PersistentStorage.shared.persistentContainer.viewContext.delete(cdUser!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    private func getCDUser(byIdentifier id: String) -> CDUser? {
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        let fetchRequest = NSFetchRequest<CDUser>(entityName: "CDUser")
        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.persistentContainer.viewContext.fetch(fetchRequest).first

            guard result != nil else {return nil}

            return result
        } catch let error {
            debugPrint(error)
        }

        return nil
    }
}
