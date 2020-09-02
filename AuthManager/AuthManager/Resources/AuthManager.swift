//
//  AuthManager.swift
//  MainApplication
//
//  Created by alpiopio on 02/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation

public protocol IAuthManager {
    var canAuthorize: Bool {get}
    
    func saveToken(type: String, token: String, refresh: String)
    func deleteToken()
}

public class AuthManager: IAuthManager {
    public static let shared = AuthManager()
    
    public var type: String = {
        let type = KeychainService.load(service: Constant.keychain.tokenType, account: Constant.keychain.account) ?? ""
        return type
    }()
    
    public var token: String = {
        let token = KeychainService.load(service: Constant.keychain.accessToken, account: Constant.keychain.account) ?? ""
        return token
    }()
    
    public var refreshToken: String = {
        let token = KeychainService.load(service: Constant.keychain.refreshToken, account: Constant.keychain.account) ?? ""
        return token
    }()
    
    public var canAuthorize: Bool {
        return token.count > 0
    }
    
    public func saveToken(type: String, token: String, refresh: String) {
        KeychainService.save(service: Constant.keychain.tokenType, account: Constant.keychain.account, data: type)
        KeychainService.save(service: Constant.keychain.accessToken, account: Constant.keychain.account, data: token)
        KeychainService.save(service: Constant.keychain.refreshToken, account: Constant.keychain.account, data: refresh)
    }
    
    public func deleteToken() {
        KeychainService.remove(service: Constant.keychain.accessToken, account: Constant.keychain.account)
        KeychainService.remove(service: Constant.keychain.refreshToken, account: Constant.keychain.account)
        KeychainService.remove(service: Constant.keychain.tokenType, account: Constant.keychain.account)
    }
}
