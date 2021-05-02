//
//  ProfileCell.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 02/05/21.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    //MARK: -properties
    
    //MARK: -Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
