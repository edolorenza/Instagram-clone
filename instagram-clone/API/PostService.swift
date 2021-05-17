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
            
            
            let docRef = COLLECTION_POSTS.addDocument(data: data,completion: completion)
            
            self.updateUserFeedAfterPost(postID: docRef.documentID)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void ) {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.map({Post(postId: $0.documentID, dictionary: $0.data())})
            completion(posts)
        }
    }
    
    static func fetchPosts(forUser uid: String, completion: @escaping([Post]) -> Void) {
        let query =  COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
       
       
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            var posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            posts.sort { (posts1, post2) -> Bool in
                return posts1.timestamp.seconds > post2.timestamp.seconds
            }
           completion(posts)
        }
    }
    
    
    static func fetchSinglePost(withPostId postId: String, completion: @escaping(Post) -> Void){
        COLLECTION_POSTS.document(postId).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            guard let data = snapshot.data() else { return }
            let post = Post(postId: snapshot.documentID, dictionary: data)
            completion(post)
        }
    }
    
    
    static func likePOst(post: Post, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_POSTS.document(post.postId).updateData(["likes": post.likes + 1])
        
        COLLECTION_POSTS.document(post.postId).collection("post-likes").document(uid).setData([:]) { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).setData([:], completion: completion)
        }
    }
    
    static func unlikePost(post: Post, completion: @escaping(FirestoreCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard post.likes > 0 else { return }
        
        COLLECTION_POSTS.document(post.postId).updateData(["likes": post.likes-1])
        
        COLLECTION_POSTS.document(post.postId).collection("post-likes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).delete(completion: completion)
        }
    }
    
    static func checkIfUserLikedPost(post: Post, completion: @escaping(Bool) -> Void ) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
            
        COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).getDocument {
            (snapshot, _) in
            guard let didLike = snapshot?.exists else { return }
            completion(didLike)
        }
    }
    
    static func updateUserFeedAfterFollowing(user: User, didFollow: Bool) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let query =  COLLECTION_POSTS.whereField("ownerUid", isEqualTo: user.uid)
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            let docIDs = documents.map({ $0.documentID })
            docIDs.forEach { id in
                if didFollow {
                    COLLECTION_USERS.document(uid).collection("user-feed").document(id).setData([:])
                }else {
                    COLLECTION_USERS.document(uid).collection("user-feed").document(id).delete()
                }
            }
        }
    }
    
    static func fetchFeedPosts(completion: @escaping([Post]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var posts = [Post]()
        
        COLLECTION_USERS.document(uid).collection("user-feed").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document  in
                fetchSinglePost(withPostId: document.documentID) { post in
                    posts.append(post)
                    posts.sort { (posts1, post2) -> Bool in
                        return posts1.timestamp.seconds > post2.timestamp.seconds
                    }
                    completion(posts)
                }
            })
        }
    }
    
    private static func updateUserFeedAfterPost(postID: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach { documents in
                COLLECTION_USERS.document(documents.documentID).collection("user-feed").document(postID).setData([:])
            }
            
            COLLECTION_USERS.document(uid).collection("user-feed").document(postID).setData([:])
        }
    }
}
