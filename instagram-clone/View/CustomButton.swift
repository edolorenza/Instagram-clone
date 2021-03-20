//
//  CustomButton.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 20/03/21.
//

import UIKit

class CustomButton: UIButton {
    
     init(title: String) {
        super.init(frame: .zero)
        setTitleColor(.white, for: .normal)
        setHeight(50)
        backgroundColor = .systemBlue
        layer.cornerRadius = 5.0
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        setTitle(title, for: .normal)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) Has Not Been Implemented")
    }
    
}
