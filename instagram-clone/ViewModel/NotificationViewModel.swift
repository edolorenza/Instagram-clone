//
//  NotificationViewModel.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 16/05/21.
//

import Foundation

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
    
    var username: String {
        return notification.username ?? ""
    }
}

