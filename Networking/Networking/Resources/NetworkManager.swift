//
//  NetworkManager.swift
//  PreTest
//
//  Created by alpiopio on 15/01/20.
//  Copyright © 2020 alpiopio. All rights reserved.
//

import UIKit
import AuthManager

public struct NetworkManager {
    public static let instance = NetworkManager()
    private let router = Router<ServiceAPI>()
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    private init() {}
    
    @discardableResult
    public func requestObject<T: EndPointType>(_ t: T, completion: @escaping (Result<Bool, NetworkError>) -> Void) -> String {
        return router.request(t as! ServiceAPI) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.certificationError))
                return
            }
            switch self.handleNetworkResponse(response) {
            case .success:
                if let data = data, error == nil {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                        print(json ?? "Empty")
                    } catch {
                        print(error.localizedDescription)
                    }
                    completion(.success(true))
                }
            case .failure(let err):
                if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code != NSURLErrorCancelled {
                    completion(.failure(NetworkError.unknown))
                    return
                } else {
                    switch err {
                    case .authenticationError:
                        self.forceLogout()
                    case .badRequest:
                        completion(.failure(NetworkError.badRequest))
                    default:
                        if let data = data {
                            let result = self.decode(with: data, c: ErrorResponse.self)
                            switch result {
                            case .success(let object):
                                let message = object.error
                                    .errors.map { (error) -> String in
                                        return error.param + " " + error.messages.joined(separator: ", ")
                                    }.joined(separator: ", ")
                                completion(.failure(NetworkError.softError(message: message)))
                            case .failure(let error):
                                print("Url:", response.url?.absoluteString ?? "nil")
                                print("Status code:", response.statusCode)
                                completion(.failure(error))
                            }
                        }
                    }
                }
            }
        }
    }
    
    @discardableResult
    public func requestObject<T: EndPointType, C: Decodable>(_ t: T, c: C.Type, completion: @escaping (Result<C, NetworkError>) -> Void) -> String {
        return router.request(t as! ServiceAPI) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.certificationError))
                return
            }
            switch self.handleNetworkResponse(response) {
            case .success:
                if let data = data, error == nil {
                    let result = self.decode(with: data, c: c)
                    switch result {
                    case .success(let object):
                        completion(.success(object))
                    case .failure(let error):
                        print("Url:", response.url?.absoluteString ?? "nil")
                        print("Status code:", response.statusCode)
                        completion(.failure(error))
                    }
                }
            case .failure(let err):
                if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code != NSURLErrorCancelled {
                    completion(.failure(NetworkError.unknown))
                    return
                } else {
                    switch err {
                    case .authenticationError:
                        self.forceLogout()
                    case .badRequest:
                        completion(.failure(NetworkError.badRequest))
                    default:
                        if let data = data {
                            let result = self.decode(with: data, c: ErrorResponse.self)
                            switch result {
                            case .success(let object):
                                let message = object.error
                                    .errors.map { (error) -> String in
                                        return error.param + " " + error.messages.joined(separator: ", ")
                                    }.joined(separator: ", ")
                                completion(.failure(NetworkError.softError(message: message)))
                            case .failure(let error):
                                print("Url:", response.url?.absoluteString ?? "nil")
                                print("Status code:", response.statusCode)
                                completion(.failure(error))
                            }
                        }
                    }
                }
            }
        }
    }
    
    public func cancel() {
        router.cancel()
    }
    
    public func cancel(with url: String) {
        router.cancel(with: url)
    }
    
    private func forceLogout() {
        AuthManager.shared.deleteToken()
        NotificationCenter.default.post(name: Notification.Name(NetworkingGlobalConstant.userLogout), object: nil)
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<Bool, NetworkError> {
        switch response.statusCode {
        case 200...299: return .success(true)
        case 401, 403: return .failure(NetworkError.authenticationError)
        case 404: return .failure(NetworkError.pageNotFound)
        case 402, 405...499: return .failure(NetworkError.somethingWentWrong)
        case 500...599: return .failure(NetworkError.badRequest)
        case 600: return .failure(NetworkError.outDated)
        default: return .failure(NetworkError.failed)
        }
    }
    
    private func decode<C: Decodable>(with data: Data, c: C.Type) -> Result<C, NetworkError> {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            print(json ?? "Empty")
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            let data = try self.jsonDecoder.decode(c.self, from: data)
            return .success(data)
         } catch let DecodingError.dataCorrupted(context) {
            print(context)
            return .failure(NetworkError.unableToDecode)
         } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return .failure(NetworkError.unableToDecode)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return .failure(NetworkError.unableToDecode)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return .failure(NetworkError.unableToDecode)
         } catch {
            return .failure(NetworkError.unknown)
         }
    }
}
