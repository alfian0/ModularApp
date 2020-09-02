//
//  DetailViewModel.swift
//  MainApplication
//
//  Created by alpiopio on 02/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation

protocol IDetailViewModel {
    
}

class DetailViewModel: IDetailViewModel {
    private let id: String
    
    init(with id: String) {
        self.id = id
    }
}
