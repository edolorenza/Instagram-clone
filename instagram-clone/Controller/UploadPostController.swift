//
//  UploadPostController.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 04/05/21.
//

import UIKit

protocol UploadPostControllerDelegte: class {
    func controllerDidFinishUploadLoadingPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
    //MARK: - Properties
    weak var delegate: UploadPostControllerDelegte?
    
    var currentUser: User?
    
    var selectedImage: UIImage? {
        didSet { photoImageView.image = selectedImage }
    }
    
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private lazy var captionText: InputTextView = {
        let tv = InputTextView()
        tv.placeHolderText = "Enter caption..."
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.delegate = self
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
        self.delegate?.controllerDidFinishUploadLoadingPost(self)
        print("DEBUG: cancel post")
    }
    
    @objc func didTapShare() {
        guard let image = selectedImage else { return }
        guard let caption = captionText.text else { return }
        guard let user = currentUser else { return }
        
        showLoader(true)
        
        PostService.uploadPost(caption: caption, image: image, user: user) { error in
            self.showLoader(false)
            if let error = error {
                print("DEBUG: failed to upload post with error \(error.localizedDescription)")
                return
            }
            self.delegate?.controllerDidFinishUploadLoadingPost(self)
        }
    }
    //MARK: - Helpers
    func checkMaxLength(_ textView: UITextView) {
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
    }
    
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
        captionText.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: photoImageView.rightAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 12, paddingRight: 16, height: 80)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(top: photoImageView.bottomAnchor, right: view.rightAnchor, paddingRight: 16)
    }
}

//MARK: - UITextViewDelegate

extension UploadPostController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}
