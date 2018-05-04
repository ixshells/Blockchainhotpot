//
//  ViewController.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 26/04/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import UIKit

class knowledgesViewModel {
    static var knowledges:[String] = ["区块链", "智能合约", "加密货币", "挖矿", "共识机制", "区块链分类", "token与币的区别", "钱包", "比特币", "以太坊", "转账", "交易"]
}

class KnowledgeVabaseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.frame.size.width/2 - 30, height: (self.view.frame.width/2 - 40)/2)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 60)

        collectionView.collectionViewLayout = flowLayout
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = false
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return knowledgesViewModel.knowledges.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "knowledgebaseHeader", for: indexPath)
        return header
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:KnowledgebaseCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "knowledgebaseitem", for: indexPath) as! KnowledgebaseCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = self.view.frame.size.width/55
        cell.setTitle(title: knowledgesViewModel.knowledges[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsCtrl = self.storyboard?.instantiateViewController(withIdentifier: "knowledgebaseDetails") as! KnowledgebaseDetailsViewController
        detailsCtrl.knowledgebaseDetails = KnowledgebaseDetails(title: knowledgesViewModel.knowledges[indexPath.row], detalsUrl: "https://www.jianshu.com/p/5c10fafdf25e")
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.show(detailsCtrl, sender: self)
    }

}

