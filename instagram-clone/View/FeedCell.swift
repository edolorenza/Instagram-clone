//
//  FeedCell.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 18/03/21.
//

import UIKit

class FeedCell: UICollectionViewCell{
    //MARK: - Properties
    
    var viewModel: PostViewModel? {
        didSet{
            configure()
        }
    }
    
    private let profileImageView: UIImageView =  {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    
    private lazy var usernameButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Venom", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    private let postImageView: UIImageView =  {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "avenger")
        return iv
    }()
    
    private lazy var likeButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var commentButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var shareButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    
    private let likeLabel: UILabel =  {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    private let captionLabel: UILabel =  {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let postTimeLabel: UILabel =  {
        let label = UILabel()
        label.text = "Two days ago"
        label.font = UIFont.systemFont(ofSize: 12)
        label.alpha = 0.5
        return label
    }()
    
    private var stackView = UIStackView()
    //MARK: - lifecycle
    
    override init (frame: CGRect){
    super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40/2
        
        self.addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView,
                               leftAnchor: profileImageView.rightAnchor,
                               paddingLeft: 12)
        
        self.addSubview(postImageView)
        postImageView.anchor(top:profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        configureActionButton()
        
        self.addSubview(likeLabel)
        likeLabel.anchor(top: stackView.bottomAnchor, left: leftAnchor, paddingTop: -4, paddingLeft: 10)
        
        self.addSubview(captionLabel)
        captionLabel.anchor(top: likeLabel.bottomAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 10)
        
        self.addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) Has Not Been Implemented")
    }
    
    //MARK: - Actions
    @objc func didTapUsername() {
        
    }
    
    //MARK: - helpers
    
    func configureActionButton(){
        stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        self.addSubview(stackView)
        stackView.anchor(top: postImageView.bottomAnchor, width: 120, height: 50)
    }
    
    func configure() {
        guard let viewModel = viewModel else {  return }
        captionLabel.text = viewModel.caption
        postImageView.sd_setImage(with: viewModel.imageUrl)
        likeLabel.text = "\(viewModel.likes) likes"
    }
}
