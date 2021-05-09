//
//  CommentViewModel.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 09/05/21.
//

import UIKit

struct CommentViewModel {
    private let comment: Comment
    
    var profileImageUrl: URL? {
        return URL(string: comment.profileImageUrl)
    }
    
    var username: String{
        return comment.username
    }
    
    var commentText: String {
        return comment.commentText
    }
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    func commentLabel() -> NSAttributedString {
        let atributedString = NSMutableAttributedString(string: "\(username) ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        atributedString.append(NSAttributedString(string: "\(commentText)", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        return atributedString
    }
    
    func size(forWidth widht: CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = comment.commentText
        label.lineBreakMode = .byWordWrapping
        label.setWidth(widht)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
