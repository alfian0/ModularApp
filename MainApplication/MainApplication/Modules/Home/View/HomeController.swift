//
//  HomeController.swift
//  MainApplication
//
//  Created by alpiopio on 02/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import UIKit

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

    }

}
