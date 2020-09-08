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
import AuthManager

class HomeController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
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

        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(onTapProfile(_:)))
        // MARK: Handle when get 403 unauthorize
        NotificationCenter.default.addObserver(self, selector: #selector(onUserLogout(_:)), name: Notification.Name(NetworkingGlobalConstant.userLogout), object: nil)
    }
    
    @objc
    private func onUserLogout(_ sender: NSNotification) {
        print("Logout")
    }

    @objc
    private func onTapProfile(_ sender: UIBarButtonItem) {
        let viewController = ProfileController()
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.itemOfRowsInIndexPath(indexPath: indexPath)
        let cell = UITableViewCell()
        cell.textLabel?.text = item?.name
        cell.accessoryType = (item?.isSelected ?? false) ? .checkmark : .none
        return cell
    }
}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indicies = viewModel.didSelectRowAt(indexPath: indexPath)
        tableView.reloadRows(at: indicies, with: .automatic)
    }
}
