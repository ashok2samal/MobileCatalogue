//
//  AddEditViewController.swift
//  MobileCatalogue
//
//  Created by Ashok Samal on 07/06/18.
//  Copyright © 2018 Ashok Samal. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {
    
    var tableViewController : TableViewController?
    var inMsg : String?
    var sourceObj : MobileDetailsModel?
    @IBOutlet var mobileDetails: [UITextField]!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if inMsg != "Add" {
            sourceObj = tableViewController?.viewModel.mobileArr[(tableViewController?.selectedRow)!]
            if inMsg == "Edit" {
                self.navigationItem.title = "Edit Details"
            } else {
                self.navigationItem.title = "Specifications"
            }
        } else {
            self.navigationItem.title = "Add Mobile"
        }
        tableViewController?.selectedRow = -1
        if let inObj = sourceObj {
            populateValues(fromObject: inObj)
        }
        
        for textField in mobileDetails {
            textField.addTarget(self, action: #selector(self.textDidChange(sender:)), for: UIControlEvents.editingChanged)
        }
        saveButton.isEnabled = false
    }
    
    @objc func textDidChange(sender: UITextField) {
        var count = 0
        for textField in mobileDetails {
            if textField.tag <= 3 {
                if textField.text != nil && textField.text != "" {
                    count += 1
                }
            }
        }
        if count == 3 {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    func populateValues(fromObject obj:MobileDetailsModel) {
        for textField in mobileDetails {
            switch textField.tag {
            case 1:
                textField.text = obj.name
            case 2:
                textField.text = obj.model
            case 3:
                textField.text = obj.color
            case 4:
                textField.text = "\(obj.cost.value ?? 0)"
            case 5:
                textField.text = obj.primaryCamera
            case 6:
                textField.text = obj.secondaryCamera
            case 7:
                textField.text = "\(obj.battery.value ?? 0)"
            case 8:
                textField.text = obj.memory
            default:
                continue
            }
            if inMsg == "Detail" {
                textField.isEnabled = false
            }
        }
        if inMsg == "Detail" {
            cancelButton.isHidden = true
            saveButton.isHidden = true
        }
    }
    
    @IBAction func saveMobileDetails(_ sender: UIButton) {
        let sObj = MobileDetailsModel()
        for textField in mobileDetails {
            switch textField.tag {
            case 1:
                sObj.name = textField.text
            case 2:
                sObj.model = textField.text
            case 3:
                sObj.color = textField.text
            case 4:
                sObj.cost.value = Int(textField.text!)
            case 5:
                sObj.primaryCamera = textField.text
            case 6:
                sObj.secondaryCamera = textField.text
            case 7:
                sObj.battery.value = Int(textField.text!)
            case 8:
                sObj.memory = textField.text
            default:
                continue
            }
        }
        if inMsg == "Edit" {
            tableViewController?.viewModel.updateRealmObject(existingObj: sourceObj!, editedObj: sObj)
        } else {
            tableViewController?.viewModel.writeToFile(mobileObj: sObj)
        }
        tableViewController?.loadData()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didCancelAddOrEdit(_ sender: UIButton) {
        inMsg = nil
        sourceObj = nil
        self.navigationController?.popToRootViewController(animated: true)
    }
}
