//
//  SettingViewController.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 23/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "关于"
        self.navigationController?.navigationBar.prefersLargeTitles = false;
        self.tabBarController?.tabBar.isHidden = true
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


}
