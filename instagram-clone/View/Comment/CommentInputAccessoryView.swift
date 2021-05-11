//
//  CommentInputAccessoryView.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 08/05/21.
//

import UIKit

protocol CommentInputAccessoryViewDelegate: AnyObject {
    func inputview(_ inputView: CommentInputAccessoryView, wantsToUploadComment comment: String)
}

class CommentInputAccessoryView: UIView {
    
    //MARK: - Properties
    weak var commentDelegate: CommentInputAccessoryViewDelegate?
    
    private let commentTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeHolderText = "Enter comment..."
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.isScrollEnabled = false
        return tv
    }()
    
    private let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let divider = UIView()


    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame )
        autoresizingMask = .flexibleHeight
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    func setupView() {
        backgroundColor = .white
        addSubview(postButton)
        postButton.anchor(top: topAnchor, right: rightAnchor, paddingRight: 8)
        postButton.setDimensions(height: 50, width: 50)
        
        addSubview(commentTextView)
        commentTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right:                                         postButton.leftAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        addSubview(divider)
        divider.backgroundColor = .lightGray
        divider.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    }
    
    func clearCommentTextView() {
        commentTextView.text = nil
        commentTextView.placeHolderLabel.isHidden = false
    }
    
    override var intrinsicContentSize: CGSize{
        return .zero
    }
    
    //MARK: - Action
    @objc func postButtonTapped() {
        commentDelegate?.inputview(self, wantsToUploadComment: commentTextView.text)
    }
}
