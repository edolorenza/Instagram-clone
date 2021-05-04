//
//  UploadPostController.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 04/05/21.
//

import UIKit

class UploadPostController: UIViewController {
    //MARK: - Properties
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "avenger")
        return iv
    }()
    
    private let captionText: UITextView = {
        let tv = UITextView()
        tv.text = "Write a caption..."
        return tv
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
        
        

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
     //MARK: - Actions
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapShare() {
        print("DEBUG: Post Share here...")
    }
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapShare))
        
        view.addSubview(photoImageView)
        
        photoImageView.setDimensions(height: 120 , width: 120)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 12)
        photoImageView.layer.cornerRadius = 10
        
        view.addSubview(captionText)
        captionText.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: photoImageView.rightAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 12, paddingRight: 16, height: 64)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(top: photoImageView.bottomAnchor, right: view.rightAnchor, paddingRight: 16)
    }
}

