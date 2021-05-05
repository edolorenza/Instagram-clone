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
    
    var numberOfFollowers: NSAttributedString {
        return attributedStatText(value: user.stats.followers, label: "followers")
    }
    
    var numberOfFollowing: NSAttributedString {
        return attributedStatText(value: user.stats.following, label: "following")
    }
    
    var numberOfPost: NSAttributedString {
        return attributedStatText(value: user.stats.posts, label: "posts")
    }
    
    init(user: User) {
        self.user = user
    }
    
    func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }
}
