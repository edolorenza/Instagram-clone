//
//  ProfileCell.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 02/05/21.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    //MARK: -properties
    private let postImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "avenger")
        iv.clipsToBounds = true
        return iv
    }()
    //MARK: -Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
