//
//  TabBarViewController.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 14/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewConroller: UITabBarController {
    override func viewDidLoad() {
        let projectItem = self.tabBar.items?[0]
        projectItem?.badgeColor = UIColor.brown
        projectItem?.image = UIImage(named: "bitcoin")?.withRenderingMode(.alwaysOriginal)
        projectItem?.selectedImage = UIImage(named: "bitcoinSelected")?.withRenderingMode(.alwaysOriginal)

        let knowledgeItem = self.tabBar.items?[1]
        knowledgeItem?.badgeColor = UIColor.brown
        knowledgeItem?.image = UIImage(named: "ethereum")?.withRenderingMode(.alwaysOriginal)
        knowledgeItem?.selectedImage = UIImage(named: "ethereumSelected")?.withRenderingMode(.alwaysOriginal)
    }
}
