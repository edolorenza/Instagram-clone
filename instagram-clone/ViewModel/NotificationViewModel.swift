//
//  NotificationViewModel.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 16/05/21.
//

import UIKit

struct NotificationViewModel {
    private let notification: Notification
    
    init(notification: Notification){
        self.notification = notification
    }
    
    var postImageUrl: URL? {
        return URL(string: notification.postImageUrl ?? "")
    }
    
    var profileImageUrl: URL? {
        return URL(string: notification.userProfileImageUrl ?? "")
    }
    
    var notificationMessage: NSAttributedString {
        let username = notification.username ?? ""
        let message = notification.type.notificationMessage
        let atributedText = NSMutableAttributedString(string: username, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        atributedText.append(NSAttributedString(string: message, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        atributedText.append(NSAttributedString(string: "  2m", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        return atributedText
    }
    
    var shouldHidePostImage: Bool {return self.notification.type == .follow}
}

