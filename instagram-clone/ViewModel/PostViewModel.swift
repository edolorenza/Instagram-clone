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
    
    var likes: Int { return post.likes }
    
    init(post: Post){
        self.post = post
    }
}
