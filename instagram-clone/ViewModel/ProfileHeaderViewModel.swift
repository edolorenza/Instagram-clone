//
//  ProfileHeaderViewModel.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 02/05/21.
//

import UIKit

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImages: URL? {
        return URL(string: user.profileImages)
    }
    
    var followButtonText: String {
        if user.isCurrentUer {
            return "Edit Profile"
        }
        
        return user.isFollowed ? "Following" : "Follow"
    }
    
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUer || user.isFollowed ? .white : .systemBlue
    }
    
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUer || user.isFollowed ? .black : .white
    }
    
    init(user: User) {
        self.user = user
    }
}
