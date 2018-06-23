//
//  ViewController.swift
//  MobileCatalogue
//
//  Created by Ashok Samal on 06/06/18.
//  Copyright © 2018 Ashok Samal. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    var viewModel = MobileViewModel()
    var selectedRow = -1
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "All Mobiles"
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddEditViewController {
            if segue.identifier == "edit" {
                destination.inMsg = "Edit"
            } else
                if segue.identifier == "add" {
                destination.inMsg = "Add"
                destination.sourceObj = MobileDetailsModel ()
            } else {
                destination.inMsg = "Detail"
            }
            destination.tableViewController = self
        }
        
    }
    
    func loadData() {
        viewModel.loadRealmData()
        self.tableView.reloadData()
    }
    
    @IBAction func editTable(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = self.tableView.isEditing ? "Done" : "Edit"
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        selectedRow = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mobileArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "mobileCell", for: indexPath)
        let rowData = viewModel.getRowData(index: indexPath.row)
        tableViewCell.textLabel?.text = rowData.name
        tableViewCell.detailTextLabel?.text = rowData.model
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteFromFile(atIndex: indexPath.row)
            loadData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.swapRows(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}
