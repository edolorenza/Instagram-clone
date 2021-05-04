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
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImages = dictionary["profileImages"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}

