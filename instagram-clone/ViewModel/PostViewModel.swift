//
//  PostViewModel.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 05/05/21.
//

import Foundation

struct PostViewModel {
    private let post: Post
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    
    var caption: String {
        return post.caption
    }
    
    var likes: String {
        if post.likes != 1 {
            return "\(post.likes) likes"
        }else {
            return "\(post.likes) like"
        }
       
        
    }
    
    var ownerImageUrl: URL? {
        return URL(string: post.ownerImageUrl)
    }
    var ownerUsername: String{
        return post.ownerUsername
    }
    
    init(post: Post){
        self.post = post
    }
}
