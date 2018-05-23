//
//  ViewController.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 26/04/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import UIKit
import SafariServices
import SVProgressHUD

class KnowledgeBaseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var knowledgeBaseViewModel: KnowledgeBaseViewModel = KnowledgeBaseViewModel()
    var knowledges: Knowledges? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        SVProgressHUD.show()
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.isNavigationBarHidden = false
        knowledgeBaseViewModel.getKnowledgeBases({ knowledges in
            self.knowledges = knowledges
            self.collectionView.reloadData()
            SVProgressHUD.dismiss()
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = false
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (knowledges == nil) ? 0 : knowledges!.results.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "knowledgebaseHeader", for: indexPath)
        return header
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:KnowledgebaseCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "knowledgebaseitem", for: indexPath) as! KnowledgebaseCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = self.view.frame.size.width/55
        cell.setTitle(title: (knowledges?.results[indexPath.row].title)!)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsCtrl = self.storyboard?.instantiateViewController(withIdentifier: "knowledgebaseDetails") as! KnowledgebaseDetailsViewController
        detailsCtrl.knowledgeInfo = knowledges?.results[indexPath.row]
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.show(detailsCtrl, sender: self)
    }

    private func setupLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.frame.size.width/2 - 30, height: (self.view.frame.width/2 - 40)/2)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 60)

        collectionView.collectionViewLayout = flowLayout
    }

}

