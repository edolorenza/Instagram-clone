//
//  InputTextView.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 04/05/21.
//

import UIKit

class InputTextView: UITextView {

    //MARK: - Properties
    var placeHolderText: String? {
        didSet { placeHolderLabel.text = placeHolderText}
    }
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    var placeholderShouldCenter = true {
        didSet {
            if placeholderShouldCenter {
                placeHolderLabel.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 8)
               
            }else {
                placeHolderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingBottom: 8)
            }
        }
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Actions
    
    @objc func handleTextDidChange() {
        placeHolderLabel.isHidden = !text.isEmpty
    }
}
