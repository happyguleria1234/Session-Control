//
//  HomeVC.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 3/31/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift

class HomeVC: BaseVC, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var tblHome: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    var items: [String] = ["1", "2", "3", "4", "5"]
    
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
        
        navigationItem.title = LocalizableConstants.Controller.Home.title.localized()
        
        searchBar.isHidden = true
        searchBar.searchTextField.textColor = SCColor.appWhite
        
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler?.delegate = self
        
        let identifier = String(describing: HomeCell.self)
        let nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblHome.register(nibCell, forCellReuseIdentifier: identifier)
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnSearchTap(_ sender: Any) {
        searchBar.isHidden.toggle()
        if searchBar.isHidden {
            searchBar.text = nil
            searchBar.resignFirstResponder()
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if IQKeyboardManager.shared.canGoNext {
            IQKeyboardManager.shared.goNext()
        } else {
            searchBar.resignFirstResponder()
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeCell.self)) as? HomeCell {
            return cell
        }
        return UITableViewCell()
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let view: HomeHeaderView = UIView.fromNib()
        view.layoutIfNeeded()
        return view.bounds.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: HomeHeaderView = UIView.fromNib()
        view.layoutIfNeeded()
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = NavigationManager.shared.homeDetailVC
        push(controller: controller)
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = SCColor.appBackground
        setup()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NavigationManager.shared.isEnabledBottomMenu = true
    }
    
    //------------------------------------------------------
}
