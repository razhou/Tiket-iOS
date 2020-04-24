//
//  ViewController.swift
//  Tiket
//
//  Created by Jelajah Data Semesta on 21/04/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let vc = HomeViewController.init(nibName: HomeViewController.stringRepresentation, bundle: nil)
        let nav = UINavigationController(rootViewController:vc)
      
    }


}

