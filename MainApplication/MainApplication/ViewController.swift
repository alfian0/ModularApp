//
//  ViewController.swift
//  MainApplication
//
//  Created by alpiopio on 01/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import UIKit
import Networking
import Repository

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.instance.requestObject(ServiceAPI.list) { (result) in
            switch result {
            case .success(let isSuccess):
                print(isSuccess)
            case .failure(let error):
                print(error.description)
            }
        }
        
        let repository = UserDataRepository()
        if let accounts = repository.getAll(), accounts.count == 0 {
            repository.create(user: UserModel(id: UUID().uuidString, name: "Muhammad Alfiansyah", phone: "087738091779", email: "alfian.offcial.mail@gmail.com", birthDate: Date(), gender: "L", profile: "https://cdn.business2community.com/wp-content/uploads/2014/04/profile-picture-300x300.jpg"))
        } else {
            
        }
    }
    
}

