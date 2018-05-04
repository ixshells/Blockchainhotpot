//
//  KnowledgebaseCollectionCell.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 01/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation
import UIKit

class KnowledgebaseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var knowledgebaseTitle: UILabel!

    func setTitle(title: String)  {
        knowledgebaseTitle.text = title
    }
}
