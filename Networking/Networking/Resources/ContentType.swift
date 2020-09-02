//
//  ContentType.swift
//  PreTest
//
//  Created by alpiopio on 15/01/20.
//  Copyright © 2020 alpiopio. All rights reserved.
//

import Foundation

enum ContentType: String {
    case json = "application/json"
    case multipart = "multipart/form-data"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case deviceId = "device-id"
    case local = "Locale"
    case xDeviceToken = "X-Device-Token"
    case userGroup = "User-Group"
    case sessionToken = "X-Session-Token"
}
