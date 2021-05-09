//
//  CommentService.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 08/05/21.
//

import Foundation
import Firebase
import FirebaseFirestore

struct CommentService {
    static func uploadComment(comment: String, postID: String, user: User,
                              completion: @escaping(FirestoreCompletion)) {
        let data: [String: Any] = ["uid": user.uid,
                                   "comment": comment,
                                   "timestamp": Timestamp(date: Date()),
                                   "username": user.username,
                                   "profileImageUrl": user.profileImages]
        COLLECTION_POSTS.document(postID).collection("comments").addDocument(data: data, completion: completion)
        
    }
    
    static func fetchComment(){
        
    }
}
