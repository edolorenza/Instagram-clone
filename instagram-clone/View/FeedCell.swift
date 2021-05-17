//
//  FeedCell.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 18/03/21.
//

import UIKit

protocol FeedCellDelegate: AnyObject {
    func cell(_ cell: FeedCell, wantsToShowCommentFor post: Post)
    func cell(_ cell: FeedCell, didLike post: Post)
    func cell(_ cell: FeedCell, wantsToShowUserProfile uid: String)
}


class FeedCell: UICollectionViewCell{
    //MARK: - Properties
    
    var viewModel: PostViewModel? {
        didSet{
            configure()
        }
    }
    
    weak var delegate: FeedCellDelegate?
    
    private lazy var profileImageView: UIImageView =  {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        let tap = UITapGestureRecognizer(target: self, action: #selector(showProfile))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    private lazy var usernameButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Venom", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
        return button
    }()
    
    private lazy var postImageView: UIImageView =  {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "avenger")
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLike))
        tap.numberOfTapsRequired = 2
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    lazy var likeButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return button
    }()
    
    private lazy var commentButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
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
        label.font = UIFont.systemFont(ofSize: 12)
        label.alpha = 0.5
        return label
    }()
    
    private var stackView = UIStackView()
    
    //MARK: - lifecycle
    override init (frame: CGRect){
    super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) Has Not Been Implemented")
    }
    
    //MARK: - Actions
    @objc func showProfile() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, wantsToShowUserProfile: viewModel.post.ownerUid)
    }
    
    @objc func didTapComment() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, wantsToShowCommentFor: viewModel.post)
    }
    
    @objc func didTapLike() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, didLike: viewModel.post)
    }
    
    //MARK: - helpers
    func setupView() {
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
        likeLabel.text = viewModel.likes
        likeButton.tintColor = viewModel.likeButtonTintColor
        likeButton.setImage(viewModel.likeButtonImage, for: .normal)
        
        usernameButton.setTitle(viewModel.ownerUsername, for: .normal)
        profileImageView.sd_setImage(with: viewModel.ownerImageUrl)
        
        postTimeLabel.text = viewModel.timeStampString
    }
}
