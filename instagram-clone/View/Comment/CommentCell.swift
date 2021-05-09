//
//  CommentCell.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 05/05/21.
//

import UIKit
import SDWebImage

class CommentCell: UICollectionViewCell {
    //MARK: -properties
    
    var viewModel: CommentViewModel? {
        didSet { configure() }
    }
    
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
        profileImageView.anchor(top:topAnchor, left: leftAnchor, paddingLeft: 12 )
        
        
        addSubview(commentLabel)
        commentLabel.numberOfLines = 0
        commentLabel.anchor(top:topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 8, paddingRight: 8)
        
    }
    
    func configure() {
        profileImageView.sd_setImage(with: viewModel?.profileImageUrl)
        commentLabel.attributedText = viewModel?.commentLabel()
    }
}
