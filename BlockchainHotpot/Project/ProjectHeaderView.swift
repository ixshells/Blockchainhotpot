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

    weak var delegate:ProjectHeaderViewDelegate?

    @IBOutlet weak var headerSettingButton: UIButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupSetting() {
        headerSettingButton.frame = CGRect(x: self.frame.width - 60, y: self.frame.height - 45, width: 40, height: 40)
        headerSettingButton.layer.cornerRadius = 20
        headerSettingButton.layer.masksToBounds = true
        headerSettingButton.layer.borderColor = UIColor.init(red: 0.66, green: 0.66, blue: 0.66, alpha: 0.3).cgColor
        headerSettingButton.layer.borderWidth = 1
        headerSettingButton.backgroundColor = UIColor.white
        headerSettingButton.layer.shadowRadius = 5
        headerSettingButton.layer.shadowOpacity = 0.5
    }

    @IBAction func headeSettingAction(_ sender: Any) {
        print("test")
        if delegate != nil {
            delegate?.headerSettingAction()
        }
    }

}
