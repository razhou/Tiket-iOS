//
//  ComboTextField.swift
//  Tiket
//
//  Created by Jelajah Data Semesta on 23/04/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

struct ComboItem: ComboItemProtocol {
  let id: String
  let name: String
}

protocol ComboItemProtocol {
  var id: String { get }
  var name: String { get }
}

class ComboTextField: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {

    fileprivate let picker = UIPickerView()
    fileprivate var lastSelectedRow: Int? = nil
    
    var data: [ComboItemProtocol]? {
      didSet {
        refresh()
      }
    }
    
    var icon: UIImage? {
      didSet {
        if let image = icon {
          let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.height, height: frame.size.height))
          imageView.image = image
          imageView.contentMode = .center
          imageView.backgroundColor = UIColor.clear
          rightView = imageView
          rightViewMode = .always
        }
      }
    }
    
    var selectedRow: Int? = nil {
      didSet {
        if let r = selectedRow, let theData = self.data, theData.count > r {
          self.text = self.pickerView(picker, titleForRow: r, forComponent: 0)
        } else {
          self.text = ""
        }
      }
    }
    
    var value : Any? {
      get {
        if let r = selectedRow, let theData = self.data {
          return theData[r]
        }
        
        return nil
      }
    }
    
    func refresh() {
      picker.reloadAllComponents()
      selectedRow = nil
      
      if let r = selectedRow, let theData = self.data, (theData.count > 0 && self.isFirstResponder) {
        picker.selectRow(r, inComponent: 0, animated: false)
        self.pickerView(picker, didSelectRow: r, inComponent: 0)
      }
    }
    
    override func awakeFromNib() {
      super.awakeFromNib()
      
      picker.delegate = self
      picker.dataSource = self
      
      var pickerFrame = picker.frame
      let container = UIView(frame: CGRect(x: 0,y: 0,width: pickerFrame.width, height: pickerFrame.height + 40))
      container.backgroundColor = UIColor(white: 0.95, alpha: 0.4)
      pickerFrame.origin.y = 40
      picker.frame = pickerFrame
      picker.backgroundColor = UIColor(white: 0.8, alpha: 0.6)
      container.addSubview(picker)
      picker.autoresizingMask = .flexibleWidth
      
      let button = UIButton(type: .custom)
      button.setTitleColor(UIColor.darkGray, for: UIControl.State())
      button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
      button.showsTouchWhenHighlighted = true
      button.setTitle("done".capitalized, for: UIControl.State())
      button.frame = CGRect(x: pickerFrame.width-70, y: 0, width: 70, height: 40)
      button.autoresizingMask = .flexibleLeftMargin
      button.addTarget(self, action: #selector(self.done(_:)), for: .touchUpInside)
      container.addSubview(button)
      
      let buttonC = UIButton(type: .custom)
      buttonC.setTitleColor(UIColor.gray, for: UIControl.State())
      buttonC.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
      buttonC.showsTouchWhenHighlighted = true
      buttonC.setTitle("cancel".capitalized, for: UIControl.State())
      buttonC.frame = CGRect(x: 0, y: 0, width: 70, height: 40)
      buttonC.autoresizingMask = .flexibleRightMargin
      buttonC.addTarget(self, action: #selector(self.resignFirstResponder), for: .touchUpInside)
      container.addSubview(buttonC)
      
      self.inputView = container
      icon = UIImage(named: "ic_combo")
    }
    
    override func becomeFirstResponder() -> Bool {
      if let theData = self.data {
        if let r = selectedRow, theData.count > r {
          picker.selectRow(r, inComponent: 0, animated: false)
          self.pickerView(picker, didSelectRow: r, inComponent: 0)
        } else if theData.count > 0 {
          selectedRow = 0
        }
      }
      lastSelectedRow = selectedRow
      
      return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
      let result = super.resignFirstResponder()
      
      if lastSelectedRow != selectedRow {
        selectedRow = lastSelectedRow
      }
      
      return result
    }
    
    @objc func done(_ sender: AnyObject)  {
      if let r = selectedRow, let theData = self.data, theData.count > r {
        self.sendActions(for: .valueChanged)
        lastSelectedRow = selectedRow
      }
      
      _ = resignFirstResponder()
    }
    
    
    // MARK: delegate dan datasource picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return self.data?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return self.data![row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      selectedRow = row
    }

}
