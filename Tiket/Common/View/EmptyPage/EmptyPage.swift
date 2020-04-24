//
//  EmptyPage.swift
//  Tiket
//
//  Created by Jelajah Data Semesta on 23/04/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

class EmptyPage: UIView {
    @IBOutlet weak var constMyHeight: NSLayoutConstraint!
    
    var retryButtonHandler: (() -> Void)?
    var height: CGFloat = 428 {
        didSet {
            constMyHeight.constant = height
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        constMyHeight.constant = height
    }
    static func create() -> EmptyPage {
        let views = UINib(nibName: EmptyPage.stringRepresentation, bundle: nil).instantiate(withOwner: nil, options: nil)
        let theView = views.first as! EmptyPage
        return theView
    }
    
    @IBAction func btnRetry(_ sender: Any) {
        retryButtonHandler?()
    }
}
