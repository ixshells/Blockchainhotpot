//
//  ProjectHeaderView.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 23/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation

class ProjectHeaderView: UICollectionReusableView {

    @IBOutlet weak var settingButton: UIButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupSetting() {

        settingButton.frame = CGRect(x: self.frame.width - 45, y: self.frame.height - 45, width: 40, height: 40)
        settingButton.layer.cornerRadius = 20
        settingButton.layer.masksToBounds = true
        settingButton.layer.borderColor = UIColor.init(red: 0.66, green: 0.66, blue: 0.66, alpha: 0.3).cgColor
        settingButton.layer.borderWidth = 1
        settingButton.backgroundColor = UIColor.white
        settingButton.layer.shadowRadius = 5
        settingButton.layer.shadowOpacity = 0.5
        settingButton.addTarget(self, action: #selector(settingAction), for: .touchUpInside)
    }

    func setSettingHide(hide: Bool) {
        settingButton.isHidden = !hide
    }

    @objc func settingAction() {
        print("press")
    }
}
