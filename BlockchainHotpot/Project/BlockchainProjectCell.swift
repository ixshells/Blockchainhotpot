//
//  BlockchainProjectCell.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 19/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation
import UIKit

class BlockchainProjectCell: UICollectionViewCell {

    @IBOutlet weak var descriptionLabelView: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    func setInfo(title: String, descrition: String) {
        self.titleLabel.text = title
        self.descriptionLabelView.text = descrition
    }

}
