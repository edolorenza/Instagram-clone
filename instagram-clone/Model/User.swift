//
//  User.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 02/05/21.
//

import Foundation
import Firebase

struct User {
    let email: String
    let username: String
    let fullname: String
    let profileImages: String
    let uid: String
    
    var isFollowed = false
    var isCurrentUer: Bool { return Auth.auth().currentUser?.uid == uid }
    
    var stats: UserStats!
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImages = dictionary["profileImages"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        
        self.stats = UserStats(followers: 0, following: 0, posts: 0)
    }
}


struct UserStats {
    let followers: Int
    let following: Int
    let posts: Int
}
