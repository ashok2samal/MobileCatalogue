//
//  MobileViewModel.swift
//  MobileCatalogue
//
//  Created by Ashok Samal on 07/06/18.
//  Copyright © 2018 Ashok Samal. All rights reserved.
//

import UIKit
import RealmSwift

class MobileViewModel: NSObject {
    
    var mobileArr: [MobileDetailsModel] = [MobileDetailsModel]()
    
    func addMobile(name: String, model: String, color: String, cost: Int, primaryCamera: String, secondaryCamera: String, battery: Int, memory: String) {
        let mobile = MobileDetailsModel()
        mobile.name = name
        mobile.model = model
        mobile.color = color
        mobile.cost.value = cost
        mobile.primaryCamera = primaryCamera
        mobile.secondaryCamera = secondaryCamera
        mobile.battery.value = battery
        mobile.memory = memory
        
        writeToFile(mobileObj: mobile)
    }
    
    func getRowData(index: Int) -> (name: String, model: String) {
        return (mobileArr[index].name!,mobileArr[index].model!)
    }
    
    func writeToFile(mobileObj: MobileDetailsModel) {
        try! realmFile.write {
            realmFile.add(mobileObj)
        }
    }
    
    func updateRealmObject(existingObj: MobileDetailsModel, editedObj: MobileDetailsModel) {
        try! realmFile.write {
            existingObj.name = editedObj.name
            existingObj.model = editedObj.model
            existingObj.color = editedObj.color
            existingObj.cost.value = editedObj.cost.value
            existingObj.primaryCamera = editedObj.primaryCamera
            existingObj.secondaryCamera = editedObj.secondaryCamera
            existingObj.battery.value = editedObj.battery.value
            existingObj.memory = editedObj.memory
        }
    }
    
    func deleteFromFile(atIndex index: Int) {
        let obj = mobileArr[index]
        try! realmFile.write {
            realmFile.delete(obj)
        }
    }
    
    func swapRows(from: Int, to: Int) {
        let movedObject = mobileArr[from]
        mobileArr.remove(at: from)
        mobileArr.insert(movedObject, at: to)
    }
    
    func loadRealmData() {
        mobileArr = Array(realmFile.objects(MobileDetailsModel.self))
    }
}
