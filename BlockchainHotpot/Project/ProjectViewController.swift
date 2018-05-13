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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "精选"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "精选"
        setupLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlockChainProject", for: indexPath)
        cell.backgroundColor = UIColor.gray
        cell.layer.cornerRadius = self.view.frame.size.width/55
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 1.0
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsCtrl = self.storyboard?.instantiateViewController(withIdentifier: "knowledgebaseDetails") as! KnowledgebaseDetailsViewController
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.show(detailsCtrl, sender: self)
    }

    private func setupLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.frame.size.width - 30, height: self.view.frame.width/4*3)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
//        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 60)

        collectionView.collectionViewLayout = flowLayout
    }

}
