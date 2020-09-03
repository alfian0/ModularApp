//
//  Certificates.swift
//  Networking
//
//  Created by alpiopio on 03/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation

struct Certificates {
    static let themoviedb = Certificates.certificate(filename: "*.themoviedb.org", withExtension: "cer")
    static let themoviedbData = Certificates.certificateData(filename: "*.themoviedb.org", withExtension: "cer")
  
    private static func certificate(filename: String, withExtension: String) -> SecCertificate {
        let bundle = Bundle(identifier: "id.alfian.Networking")
        let filePath = bundle!.url(forResource: filename, withExtension: withExtension)!
        let data = try! Data(contentsOf: filePath)
        let certificate = SecCertificateCreateWithData(nil, data as CFData)!

        return certificate
    }
    
    static func certificateData(filename: String, withExtension: String) -> Data {
        let bundle = Bundle(identifier: "id.alfian.Networking")
        let filePath = bundle!.url(forResource: filename, withExtension: withExtension)!
        let data = try! Data(contentsOf: filePath)
        return data
    }
}
