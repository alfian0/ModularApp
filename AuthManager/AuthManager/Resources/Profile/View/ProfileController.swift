//
//  ProfileController.swift
//  AuthManager
//
//  Created by alpiopio on 08/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import UIKit
import Repository

public class ProfileController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    public init() {
        super.init(nibName: "ProfileController", bundle: Bundle(for: ProfileController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Profile"
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ProfileController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AuthManager.shared.canAuthorize ? ProfileItem.allCases.count : 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let account = UserDataRepository().getAll()?.first {
            switch ProfileItem(rawValue: indexPath.row) {
            case .name:
                DispatchQueue.global().async {
                    do {
                        let data = try Data(contentsOf: URL(string: account.profile ?? "")!)
                        DispatchQueue.main.async {
                            tableView.beginUpdates()
                            cell.imageView?.image = UIImage(data: data)
                            tableView.endUpdates()
                        }
                    } catch {
                        print("Cannot load image")
                    }
                }
                cell.textLabel?.text = account.name
            case .email:
                cell.textLabel?.text = account.email
            case .phone:
                cell.textLabel?.text = account.phone
            default: break
            }
        }
        return cell
    }
}

extension ProfileController: UITableViewDelegate {
    
}
