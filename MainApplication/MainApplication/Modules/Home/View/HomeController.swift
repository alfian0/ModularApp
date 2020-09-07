//
//  HomeController.swift
//  MainApplication
//
//  Created by alpiopio on 02/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import UIKit
import Networking
import Repository

class HomeController: UIViewController {
    private var viewModel: IHomeViewModel!
    
    init(viewModel: IHomeViewModel) {
        super.init(nibName: "HomeController", bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.instance.requestObject(ServiceAPI.list, c: GenresResponse.self) { (result) in
            switch result {
            case .success(let data):
                print(data.genres.first?.name)
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        NetworkManager.instance.requestObject(ServiceAPI.list) { (result) in
            switch result {
            case .success(let isSuccess):
                print(isSuccess)
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        let repository = UserDataRepository()
        if let accounts = repository.getAll(), accounts.count == 0 {
            repository.create(user: UserModel(id: UUID().uuidString, name: "Muhammad Alfiansyah", phone: "087738091779", email: "alfian.offcial.mail@gmail.com", birthDate: Date(), gender: "L", profile: "https://cdn.business2community.com/wp-content/uploads/2014/04/profile-picture-300x300.jpg"))
        } else {
            
        }
    }

}
