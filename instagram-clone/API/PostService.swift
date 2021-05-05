//
//  PostService.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 05/05/21.
//

import UIKit
import Firebase
import FirebaseFirestore


struct PostService {
    static func uploadPost(caption: String, image: UIImage, user: User, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageUrl,
                        "ownerUid": uid,
                        "ownerImageUrl": user.profileImages,
                        "ownerUsername": user.username ] as [String : Any]
            
            COLLECTION_POSTS.addDocument(data: data,completion: completion)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void ) {
        COLLECTION_POSTS.order(by: "timestamp").getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.map({Post(postId: $0.documentID, dictionary: $0.data())})
            completion(posts)
        }
    }
}
