//
//  ProjectCollectionViewController.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 13/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation
import SVProgressHUD

class ProjectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private var projectViewModel: ProjectViewModel = ProjectViewModel()
    private var blockchainProjects: BlockchainProjects?
    private final let NAVBAR_CHANGE_POINT = 50.0
    private var settingButtonCopy: UIButton? = nil

    @IBOutlet weak var navigationRightButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var settingButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "精选"
        setupLayout()
        setupSetting();
        setupProjectsData()
        collectionView.dataSource = self
        collectionView.delegate = self

        self.navigationController?.navigationBar.prefersLargeTitles = true;
        self.navigationItem.title = "精选";
        self.navigationItem.largeTitleDisplayMode = .automatic;

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        self.title = "精选"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss();
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (blockchainProjects == nil) ? 0 : blockchainProjects!.results.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "projectHeader", for: indexPath)
        return header
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:BlockchainProjectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlockChainProject", for: indexPath) as! BlockchainProjectCell
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

        let projectInfo = blockchainProjects?.results[indexPath.row]
        cell.setInfo(title: (projectInfo?.title)!, descrition: (projectInfo?.description)!)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsCtrl = self.storyboard?.instantiateViewController(withIdentifier: "projectDetails") as! ProjectDetailsViewController
        detailsCtrl.projectInfo = blockchainProjects?.results[indexPath.row]
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.show(detailsCtrl, sender: self)
    }

    private func setupLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.frame.size.width - 30, height: self.view.frame.width/3*1.66)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsetsMake(6, 20, 20, 20);
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 80)

        collectionView.collectionViewLayout = flowLayout
    }

    private func setupSetting() {
        settingButton.layer.cornerRadius = 20
        settingButton.layer.masksToBounds = true
        settingButton.layer.borderColor = UIColor.init(red: 0.66, green: 0.66, blue: 0.66, alpha: 0.3).cgColor
        settingButton.layer.borderWidth = 1
        settingButton.backgroundColor = UIColor.white
        settingButton.layer.shadowRadius = 5
        settingButton.layer.shadowOpacity = 0.5

        navigationRightButton.layer.cornerRadius = 20
        navigationRightButton.layer.masksToBounds = true
        navigationRightButton.layer.borderColor = UIColor.init(red: 0.66, green: 0.66, blue: 0.66, alpha: 0.3).cgColor
        navigationRightButton.layer.borderWidth = 1
        navigationRightButton.backgroundColor = UIColor.white
        navigationRightButton.layer.shadowRadius = 5
        navigationRightButton.layer.shadowOpacity = 0.5
    }

    func setupProjectsData() {

        SVProgressHUD.show()
        projectViewModel.getBlockchainProjects { (blockchainProjects) in
            self.blockchainProjects = blockchainProjects
            SVProgressHUD.dismiss()
            self.collectionView.reloadData();
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = Double(scrollView.contentOffset.y);
        if (offsetY > NAVBAR_CHANGE_POINT) {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            settingButton.isHidden = true
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            settingButton.isHidden = false
        }
    }

}
