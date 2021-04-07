//
//  SessionsVC.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 3/31/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import Foundation

class SessionsVC: BaseVC, UITableViewDataSource, UITableViewDelegate, SegmentViewDelegate {
    
    @IBOutlet weak var tblSession: UITableView!
    
    @IBOutlet weak var segment1: SegmentView!
    @IBOutlet weak var segment2: SegmentView!
    
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
        
        navigationItem.title = LocalizableConstants.Controller.Sessions.title.localized()
        segment1.btn.setTitle(LocalizableConstants.Controller.Sessions.pending.localized(), for: .normal)
        segment2.btn.setTitle(LocalizableConstants.Controller.Sessions.confirmed.localized(), for: .normal)
        
        segment1.delegate = self
        segment2.delegate = self
        
        segment1.isSelected = true
        segment2.isSelected = !segment1.isSelected
        
        var identifier = String(describing: SessionPendingCell.self)
        var nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblSession.register(nibCell, forCellReuseIdentifier: identifier)
        
        identifier = String(describing: SessionConfirmedCell.self)
        nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblSession.register(nibCell, forCellReuseIdentifier: identifier)
    }
    
    func updateUI() {
        tblSession.reloadData()
    }
    
    //------------------------------------------------------
    
    //MARK: SegmentViewDelegate
    
    func segment(view: SegmentView, didChange flag: Bool) {
        
        if view == segment1 {
            segment2.isSelected = false
        } else if view == segment2 {
            segment1.isSelected = false
        }
        updateUI()
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if segment1.isSelected {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SessionPendingCell.self)) as? SessionPendingCell {
                return cell
            }
        } else if segment2.isSelected {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SessionConfirmedCell.self)) as? SessionConfirmedCell {
                return cell
            }
        }
        return UITableViewCell()
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
        
        NavigationManager.shared.isEnabledBottomMenu = true
    }
    
    //------------------------------------------------------
}
