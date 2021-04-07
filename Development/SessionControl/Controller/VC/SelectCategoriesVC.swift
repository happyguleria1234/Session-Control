//
//  SelectCategoriesVC.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 3/24/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import Foundation

class SelectCategoriesCell: UITableViewCell {
    
    @IBOutlet weak var lblName: SCRegularLabel!
    @IBOutlet weak var btnMark: SCRememberMeButton!
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func set(name string: String) {
        lblName.text = string
    }
    
    func set(isMark boolean: Bool) {
        btnMark.isRemeber = boolean
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        selectionStyle = .none
    }
}

class SelectCategoriesVC: BaseVC, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblCategories: UITableView!

    var categories: [String] = []
    var selectedCategories: [String] = []
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        //dummy category
        for index in 1...20 {
            categories.append("Category \(index)")
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnSubmitTap(_ sender: Any) {
        
        NavigationManager.shared.setupPermission()
    }
    
    @IBAction func btnSkipTap(_ sender: Any) {
                
        NavigationManager.shared.setupPermission()
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SelectCategoriesCell.self)) as? SelectCategoriesCell {
            let name = categories[indexPath.row]
            cell.set(name: name)
            cell.set(isMark: selectedCategories.contains(name))
            return cell
        }
        return UITableViewCell()
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getEmptyView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let name = categories[indexPath.row]
        if selectedCategories.contains(name) == false {
            selectedCategories.append(name)
            if let cell = tableView.cellForRow(at: indexPath) as? SelectCategoriesCell {
                cell.set(isMark: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let name = categories[indexPath.row]
        if selectedCategories.contains(name) == true {
            selectedCategories.removeAll { (arg0: String) -> Bool in
                return arg0 == name
            }
            if let cell = tableView.cellForRow(at: indexPath) as? SelectCategoriesCell {
                cell.set(isMark: false)
            }
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}
