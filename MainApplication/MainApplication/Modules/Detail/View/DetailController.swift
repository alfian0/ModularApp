//
//  DetailController.swift
//  MainApplication
//
//  Created by alpiopio on 02/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    private var viewModel: IDetailViewModel!
    
    init(viewModel: IDetailViewModel) {
        super.init(nibName: "DetailController", bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
