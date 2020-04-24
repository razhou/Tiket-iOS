//
//  BaseViewController.swift
//  Tiket
//
//  Created by Jelajah Data Semesta on 23/04/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit
import SnapKit
class BaseViewController: UIViewController {
    private lazy var noInternetView: EmptyPage = {
        let view = EmptyPage.create()
        view.constMyHeight.constant = self.view.bounds.height - UITabBar().frame.height
        return view
    }()

    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      noInternetView.removeFromSuperview()
      

    }

    func handleAPIError(error: ApiError) {
      switch error {
      case .connectionError:
        if noInternetView.superview == nil {
          let blank = noInternetView
          view.addSubview(blank)
          view.endEditing(true)
          blank.retryButtonHandler = { [weak self] in
            self?.viewWillAppear(true)
            self?.viewDidAppear(true)
           
          }
          blank.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
          }
        }
      default:
        self.showAlertMessage(vc: self, withTitle: "Information", message: error.localizedDescription, isOk: {
            
        }, isCancel: nil)
      }
    }

}
