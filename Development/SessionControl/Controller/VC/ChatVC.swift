//
//  ChatVC.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 4/1/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var lblName: SCBoldLabel!
    @IBOutlet weak var lblTime: SCRegularLabel!
    @IBOutlet weak var lblLastMessage: SCRegularLabel!
    @IBOutlet weak var viewBadge: UIView!
    @IBOutlet weak var lblBadgeCount: UILabel!
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup(user: UserModal) {
        
        lblName.text = user.fullName
        lblLastMessage.text = "user.lastMessage"
        lblTime.text = "user.updatedAt"
        
        let unread = Int.zero//user.unreadCount
        debugPrint("unread:\(unread)")
        
        if unread > 0 {
            lblBadgeCount.text = String(unread)
            isRead(value: false)
        } else {
            lblBadgeCount.text = nil
            isRead(value: true)
        }
    }
    
    func isRead(value: Bool) {
                
        let fontSize = getDynamicFontSize(fontDefaultSize: 15)
        
        if value == false {
            viewBadge.isHidden = false
            //lblName.font = DISFont.robotoRegular(size: fontSize)
            lblName.font = SCFont.poppinsBold(size: fontSize)
        } else {            
            viewBadge.isHidden = true
            lblName.font = SCFont.poppinsBold(size: fontSize)
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //------------------------------------------------------
}

class ChatVC: BaseVC, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var lblAssetName: SCRegularLabel!
    @IBOutlet weak var btnConsoleName: SCBoldLabel!
    @IBOutlet weak var lblNoRecordsFound: SCRegularLabel!
    @IBOutlet weak var tblChat: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    var users: [UserModal] = [
        UserModal(userID: "1", firstname: "John", lastname: "Doe", email: "john.doe.1@gmail.com", password: "123456", image: nil, creationDate: nil, emailVerification: nil, emailAccessToken: nil, userAccessToken: nil, disable: nil, deviceToken: nil, deviceType: nil, bio: nil, facebookID: nil, googleID: nil, appleID: nil),
        UserModal(userID: "2", firstname: "John", lastname: "Doe", email: "john.doe.2@gmail.com", password: "123456", image: nil, creationDate: nil, emailVerification: nil, emailAccessToken: nil, userAccessToken: nil, disable: nil, deviceToken: nil, deviceType: nil, bio: nil, facebookID: nil, googleID: nil, appleID: nil),
        UserModal(userID: "3", firstname: "John", lastname: "Doe", email: "john.doe.3@gmail.com", password: "123456", image: nil, creationDate: nil, emailVerification: nil, emailAccessToken: nil, userAccessToken: nil, disable: nil, deviceToken: nil, deviceType: nil, bio: nil, facebookID: nil, googleID: nil, appleID: nil)
    ]
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
        NotificationCenter.default.removeObserver(self)
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func updateUI() {
        
        lblNoRecordsFound?.isHidden = users.count != 0
        tblChat?.reloadData()
        setBadgeCount()
    }
    
    func configure() {
         
        //lblAssetName.numberOfLines = 2
        //lblAssetName.adjustsFontSizeToFitWidth = true
        //btnConsoleName.titleLabel?.numberOfLines = 2
        //btnConsoleName.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //tblChat.addSubview(refreshControl)
        //refreshControl.addTarget(self, action: #selector(refreshUsers), for: .valueChanged)
    }
    
    func resetData() {
    }
    
    func setupData() {
    }
    
    func setBadgeCount() {
        
        let badgeValue = 0
        self.navigationController?.tabBarItem.badgeValue = badgeValue == 0 ? nil : String(badgeValue)
    }
    
    func setLocalizableContent() {
        
        navigationItem.title = LocalizableConstants.Controller.Messages.title.localized()
        navigationItem.leftBarButtonItem = nil
    }

    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnNewChatTap(_ sender: Any) {
    }
        
    //------------------------------------------------------
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let realmUser = users[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatCell.self)) as? ChatCell {
            cell.selectionStyle = .none
            cell.setup(user: realmUser)
            return cell
        }
        return UITableViewCell()
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {        
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = users[indexPath.row]
        
        let controller = NavigationManager.shared.chatDetailsVC
        //controller.toRealmUser = user
        push(controller: controller)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let actionClearAll = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "Clear") { (action: UITableViewRowAction, indexPath: IndexPath) in
            
            //let user = self.users[indexPath.row]
            self.updateUI()
        }
        return [actionClearAll]
    }
    
    //------------------------------------------------------
    
    //MARK: Notification
    
    @objc func refreshMessageList(notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.updateUI()
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIView Life Cycle Method
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
              
        //NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: DISNotificationName.refreshMessageList), object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(refreshMessageList(notification:)), name: NSNotification.Name(rawValue: DISNotificationName.refreshMessageList), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocalizableContent()
        configure()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        //setupData()
        self.updateUI()
        NavigationManager.shared.isEnabledBottomMenu = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //------------------------------------------------------
}

