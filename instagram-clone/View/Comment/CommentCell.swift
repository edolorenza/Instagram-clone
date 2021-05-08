//
//  CommentCell.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 05/05/21.
//

import UIKit

class CommentCell: UICollectionViewCell {
    //MARK: -properties
    private let profileImageView: UIImageView =  {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()

    
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        let atributedString = NSMutableAttributedString(string: "Venom", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        atributedString.append(NSAttributedString(string: " text of comment...", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = atributedString
        return label
    }()
    
    
    //MARK: -Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    func setupView() {
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 48, width: 48)
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        addSubview(commentLabel)
        commentLabel.centerY(inView:profileImageView , leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
    }
}
