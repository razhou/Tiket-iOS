//
//  HomeViewController.swift
//  Tiket
//
//  Created by Jelajah Data Semesta on 22/04/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit
class HomeViewController: BaseViewController,HomeViewModelDelegate,HomeCollectionDelegate {
    
    
    @IBOutlet weak var tfRole: ComboTextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var herosViewModel = {
        HomeViewModel.init(delegate: self)
    }()
    
    lazy var homeCv = {
        HomeCollectionView.init(delegate: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setInitView()
    }

    private func setInitView(){
        self.collectionView.delegate = homeCv
        self.collectionView.dataSource = homeCv
        self.collectionView.register(UINib.init(nibName: HeroCell.stringRepresentation, bundle: nil), forCellWithReuseIdentifier: HeroCell.stringRepresentation)
        herosViewModel.fetchApiGetHeros()
    }

    func onItemClick(hero: HeroElement) {
        
    }
    
    func load(isLoad: Bool) {
        
        isLoad ? self.showHud("") : self.hideHUD()
    }
    
    func success(response: Hero) {
        self.homeCv.heros = response
        self.collectionView.reloadData()
    }
    
    func error(error: ApiError) {
        handleAPIError(error: error)
        
    }
    
    

}
