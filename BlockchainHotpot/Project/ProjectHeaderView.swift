//
//  ProjectHeaderView.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 23/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation

protocol ProjectHeaderViewDelegate: NSObjectProtocol {
    func headerSettingAction()
}

class ProjectHeaderView: UICollectionReusableView {

    weak var delegate: ProjectHeaderViewDelegate?

    @IBOutlet weak var headerSettingButton: UIButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBAction func headeSettingAction(_ sender: Any) {
        print("test")
        if delegate != nil {
            delegate?.headerSettingAction()
        }
    }

}
