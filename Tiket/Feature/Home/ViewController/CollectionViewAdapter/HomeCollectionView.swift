//
//  HomeCollectionView.swift
//  Tiket
//
//  Created by Jelajah Data Semesta on 23/04/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import UIKit

class HomeCollectionView:NSObject,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var heros : Hero = []
    var delegate : HomeCollectionDelegate?
    
    init(delegate: HomeCollectionDelegate ) {
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroCell.stringRepresentation, for: indexPath) as! HeroCell
        let hero = heros[indexPath.row]
        if let image = hero.img, let url = URL(string:Constants.baseUrl + image) {
            cell.imgHero.downloadWithTransition(image: url)
        }
        cell.lblTypeHero.text = hero.localizedName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = heros[indexPath.row]
        delegate?.onItemClick(hero: hero)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 8, left:13 , bottom: 8, right: 13)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       let width = collectionView.frame.size.width - 2 * 13
        return CGSize(width: (width - 22 - 2 * 13) / 3, height: 250)
    }
    
  
}

protocol HomeCollectionDelegate {
    func onItemClick(hero:HeroElement)
}
