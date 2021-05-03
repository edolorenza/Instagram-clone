//
//  UserCellViewModel.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 03/05/21.
//

import Foundation

struct UserCellViewModel {
    
    private let user: User
    
    var profileImages: URL? {
        return URL(string: user.profileImages)
    }
    
    var username: String{
        return user.username
    }
    
    var fullname: String{
        return user.fullname
    }
    
    init(user: User) {
        self.user = user
    }
}
