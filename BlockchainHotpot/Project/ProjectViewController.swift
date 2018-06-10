//
//  ProjectCollectionViewController.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 13/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation
import SVProgressHUD
import MJRefresh

class ProjectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, ProjectHeaderViewDelegate {
    private var projectViewModel: ProjectViewModel = ProjectViewModel()
    private var blockchainProjects: BlockchainProjects?
    private final let NAVBAR_CHANGE_POINT = 44.0
    private var header: ProjectHeaderView? = nil
    @IBOutlet weak var navigationRightButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var settingButtonFromHeader: UIButton!
    let navigationView = UIView()
    let seperatorView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "精选"
        setupLayout()
        SVProgressHUD.show()
        headerFresh()
        collectionView.dataSource = self
        collectionView.delegate = self

        self.navigationItem.title = "精选";
        self.navigationItem.largeTitleDisplayMode = .automatic;

        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)

        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        header.setRefreshingTarget(self, refreshingAction: #selector(headerFresh))
        self.collectionView.mj_header = header

        let footer = MJRefreshAutoNormalFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.collectionView.mj_footer = footer

        setupNavigationView()
    }

    @objc func headerFresh() {
        projectViewModel.getBlockchainProjects { (blockchainProjects) in
            self.blockchainProjects = blockchainProjects
            SVProgressHUD.dismiss()
            self.collectionView.reloadData();
            self.collectionView.mj_header.endRefreshing()
        }
    }

    @objc func footerRefresh() {
        print("footer fresh")

        guard blockchainProjects?.cursor != nil else {
            self.collectionView.mj_footer.endRefreshingWithNoMoreData()
            SVProgressHUD.dismiss()
            return
        }

        projectViewModel.getNextPageProjects((blockchainProjects?.cursor)!) { (blockchainProjects) in
            self.blockchainProjects?.cursor = blockchainProjects?.cursor

            if (blockchainProjects != nil) {
                self.blockchainProjects?.results += blockchainProjects!.results
            }

            self.collectionView.reloadData();
            self.collectionView.mj_footer.endRefreshing()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.title = "精选"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (blockchainProjects == nil) ? 0 : blockchainProjects!.results.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "projectHeader", for: indexPath) as? ProjectHeaderView
        header?.delegate = self
        return header!
    }

    func headerSettingAction() {
        settingAction()
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
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 100)

        collectionView.collectionViewLayout = flowLayout
    }


    @objc func settingAction() {
        let settingViewCtrl = self.storyboard?.instantiateViewController(withIdentifier: "settingViewController")
        self.navigationController?.show(settingViewCtrl!, sender: nil)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = Double(scrollView.contentOffset.y);
        let alpha = min(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64))
        if (offsetY > NAVBAR_CHANGE_POINT) {
            navigationView.isHidden = false
            navigationView.alpha = CGFloat(alpha)
            seperatorView.isHidden = alpha < 0.85
        } else {
            navigationView.isHidden = true
        }
    }

    func setupNavigationView() {
        navigationView.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 50)
        navigationView.backgroundColor = UIColor.white
        self.view.addSubview(navigationView)

        seperatorView.frame = CGRect(x: 0, y: 49, width: self.view.frame.width, height: 1)
        seperatorView.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
        navigationView.addSubview(seperatorView)

        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        titleLabel.textAlignment = .center
        titleLabel.font.withSize(12)
        titleLabel.text = "精选"
        navigationView.addSubview(titleLabel)
    }
}
