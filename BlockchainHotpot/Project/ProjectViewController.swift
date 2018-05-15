//
//  ProjectCollectionViewController.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 13/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation

class ProjectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var settingButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.title = "精选"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "精选"
        setupLayout()
        collectionView.dataSource = self
        collectionView.delegate = self

        settingButton.layer.cornerRadius = 20
        settingButton.layer.masksToBounds = true
        settingButton.layer.borderColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3).cgColor
        settingButton.layer.borderWidth = 1
        settingButton.backgroundColor = UIColor.white
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "projectHeader", for: indexPath)
        return header
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlockChainProject", for: indexPath)
        let shadowPath = UIBezierPath.init(rect: cell.bounds)
        let cornerRadius = self.view.frame.size.width/55
        cell.layer.cornerRadius = cornerRadius
        cell.contentView.layer.cornerRadius = cornerRadius
        cell.contentView.layer.masksToBounds = true

        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOpacity = 0.8
        cell.layer.shadowRadius = 4
        cell.layer.shadowOffset = CGSize(width: 4, height: 4)
        cell.layer.shadowPath = shadowPath.cgPath
        cell.layer.masksToBounds = false

        return cell
    }

    private func setupLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.frame.size.width - 30, height: self.view.frame.width/4*3)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsetsMake(6, 20, 20, 20);
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 80)

        collectionView.collectionViewLayout = flowLayout
    }

}
