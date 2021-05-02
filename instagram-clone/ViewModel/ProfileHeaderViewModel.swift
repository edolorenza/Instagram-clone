//
//  ProfileHeaderViewModel.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 02/05/21.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImages: URL? {
        return URL(string: user.profileImages)
    }
    
    init(user: User) {
        self.user = user
    }
}
