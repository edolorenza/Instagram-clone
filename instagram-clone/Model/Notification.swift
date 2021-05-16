//
//  Notification.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 16/05/21.
//

import Foundation
import FirebaseFirestore

enum NotificationType: Int {
    case like
    case follow
    case comment
    
    var notificationMessage: String {
        switch self {
        case .like:
            return " liked your post."
        case .follow:
            return " started following you."
        case .comment:
            return " comment your post"
        }
    }
}

struct Notification {
    let uid: String
    let timestamp: Timestamp
    var postImageUrl: String?
    var postId: String?
    let type: NotificationType
    let id: String
    let userProfileImageUrl: String?
    let username: String?
    var userIsFollowed = false
    
    init(dictionary: [String: Any]) {
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.id = dictionary["id"] as? String ?? ""
        self.postImageUrl = dictionary["postImageUrl"] as? String ?? ""
        self.postId = dictionary["postId"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.userProfileImageUrl = dictionary["userProfileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.type = NotificationType(rawValue: dictionary["type"] as? Int ?? 0) ?? .like
    }
}


