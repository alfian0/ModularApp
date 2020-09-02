//
//  ServiceAPI.swift
//  Networking
//
//  Created by alpiopio on 01/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation
import AuthManager

public enum ServiceAPI {
    case list
}

extension ServiceAPI: EndPointType {
    public var baseURL: URL {
        switch self {
        default:
            guard let url = URL(string: "https://api.themoviedb.org/3") else { fatalError("baseURL could not be configured.")}
            return url
        }
    }
    
    public var path: String {
        switch self {
        default:
            return "/genre/movie/list"
        }
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .list:
            return [
                "api_key": "b9b1ce148f81f4ef0848a778a89e3fc9"
            ]
        default:
            return nil
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .list:
            return .requestCompositeParameters(bodyParameters: [:], bodyEncoding: .urlEncoding, urlParameters: parameters ?? [:])
        default:
            return .request
        }
    }
    
    public var header: [String : String]? {
        switch self {
        case .list:
            return [
                HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue,
                HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue
            ]
        default:
            return [
                HTTPHeaderField.authentication.rawValue: AuthManager.shared.type + " " + AuthManager.shared.token,
                HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue,
                HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue
            ]
        }
    }
}
