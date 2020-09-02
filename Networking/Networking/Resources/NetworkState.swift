//
//  NetworkState.swift
//  MOSAT
//
//  Created by alpiopio on 14/05/20.
//  Copyright © 2020 PT Privy Identitas Digital. All rights reserved.
//

import Foundation

enum NetworkState<T> {
    case loading
    case success(T)
    case failed(String)
}
