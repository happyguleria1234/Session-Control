//
//  NotificationsVC.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 3/4/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import Foundation
import KRPullLoader

class NotificationsVC: BaseVC, UITableViewDataSource, UITableViewDelegate, KRPullLoadViewDelegate {
    
    @IBOutlet weak var tblNotification: UITableView!
    @IBOutlet weak var lblNoRecordsFound: SCRegularLabel!
    
    /*var items: [ [String:String] ] = [ ["name": "Dog", "date": "9th Jan, 2021", "status": RequestStatus.pending.rawValue], ["name": "Elephant", "date": "11th Jan, 2021", "status": RequestStatus.approved.rawValue], ["name": "Rabbit", "date": "13th Jan, 2021", "status": RequestStatus.declined.rawValue], ["name": "Kangaroo", "date": "8th Feb, 2021", "status": RequestStatus.approved.rawValue], ["name": "Fox", "date": "15th Mar, 2021", "status": RequestStatus.approved.rawValue], ["name": "Dog", "date": "9th Jan, 2021", "status": RequestStatus.pending.rawValue], ["name": "Elephant", "date": "11th Jan, 2021", "status": RequestStatus.approved.rawValue], ["name": "Rabbit", "date": "13th Jan, 2021", "status": RequestStatus.declined.rawValue], ["name": "Kangaroo", "date": "8th Feb, 2021", "status": RequestStatus.approved.rawValue], ["name": "Fox", "date": "15th Mar, 2021", "status": RequestStatus.approved.rawValue] ]*/
    
    var notifications: [RequestModal] = []
    var isRequesting: Bool = false
    var lastRequestId: String = String()
    
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
        
        navigationItem.title = LocalizableConstants.Controller.Notifications.title.localized()
        
        let identifier = String(describing: NotificationsCell.self)
        let nibRequestCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblNotification.register(nibRequestCell, forCellReuseIdentifier: identifier)
        
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        tblNotification.addPullLoadableView(loadMoreView, type: .refresh)
    }
    
    func updateUI() {
        
        lblNoRecordsFound.text = LocalizableConstants.Controller.Notifications.noRecordsFound.localized()
        lblNoRecordsFound.isHidden = notifications.count != .zero
        tblNotification.reloadData()
    }
    
    private func performToGetAllSavedTracks(completion:((_ flag: Bool) -> Void)?) {
      
        isRequesting = true
        
        let parameter: [String: Any] = [
            Request.Parameter.search: String(),
            Request.Parameter.lastRequestId: lastRequestId
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.getNotificationList, parameter: parameter, showLoader: false, decodingType: ResponseModal<[RequestModal]>.self, successBlock: { (response: ResponseModal<[RequestModal]>) in
                
            self.isRequesting = false
            
            if response.code == Status.Code.success {
                if self.lastRequestId.isEmpty {
                    self.notifications.removeAll()
                }
                self.notifications.append(contentsOf: response.data ?? [])
                completion?(true)
                
            } else {
                completion?(true)
            }
            
        }, failureBlock: { (error: ErrorModal) in
          
            self.isRequesting = false
            completion?(false)
            
            delay {
                self.handleError(code: error.code)
            }
        })
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NotificationsCell.self)) as? NotificationsCell {
            let request = notifications[indexPath.row]
            cell.setup(request)
            return cell
        }
        return UITableViewCell()
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //------------------------------------------------------
    
    //MARK: KRPullLoadViewDelegate
    
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        
        if type == .refresh {
            switch state {
            case .none:
                pullLoadView.messageLabel.text = String()
            case let .pulling(offset, threshould):
                if offset.y > threshould {
                    pullLoadView.messageLabel.text = LocalizableConstants.Controller.Pages.pullMore.localized()
                } else {
                    pullLoadView.messageLabel.text = LocalizableConstants.Controller.Pages.releaseToRefresh.localized()
                }
            case let .loading(completionHandler):
                pullLoadView.messageLabel.text = LocalizableConstants.Controller.Pages.updating.localized()
                if isRequesting == false {
                    self.lastRequestId = String()
                    performToGetAllSavedTracks { (flag: Bool) in
                        self.updateUI()
                        completionHandler()
                    }
                } else {
                    completionHandler()
                }
            }
        } else if type == .loadMore {
            switch state {
            case let .loading(completionHandler):
                if isRequesting == false {
                    self.lastRequestId = String()
                    performToGetAllSavedTracks { (flag: Bool) in
                        self.updateUI()
                        completionHandler()
                    }
                } else {
                    completionHandler()
                }
            default: break
            }
            return
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        lblNoRecordsFound.text = LocalizableConstants.Controller.Pages.updating.localized()
        
        performToGetAllSavedTracks { (flag: Bool) in
            self.updateUI()
        }
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NavigationManager.shared.isEnabledBottomMenu = true
    }
    
    //------------------------------------------------------
}
