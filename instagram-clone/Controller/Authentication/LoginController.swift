//
//  LoginController.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 19/03/21.
//

import UIKit

class LoginController: ViewController{
    //MARK: - Properties
    private let logoImageView: UIImageView =  {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "instagramLogo")
        return iv
    }()
    private let emailTextField: UITextField =  {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.layer.cornerRadius = 5.0
        tf.layer.borderWidth = 0.1
        tf.layer.masksToBounds = true
        tf.textColor = .black
        tf.backgroundColor = .init(white: 0.5, alpha: 0.1)
        tf.keyboardAppearance = .light
        tf.keyboardType = .emailAddress
        tf.setHeight(50)
        tf.attributedPlaceholder = NSAttributedString(string: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField =  {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.layer.cornerRadius = 5.0
        tf.layer.borderWidth = 0.1
        tf.clipsToBounds = true
        tf.textColor = .black
        tf.backgroundColor = .init(white: 0.5, alpha: 0.1)
        tf.keyboardAppearance = .light
        tf.keyboardType = .alphabet
        tf.setHeight(50)
        tf.isSecureTextEntry = true
        tf.attributedPlaceholder = NSAttributedString(string: "Password")
        return tf
    }()
    
    private let forgotPasswordButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Login", for: .normal)
        button.setHeight(50)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let ats: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), .font: UIFont.systemFont(ofSize: 16)]
        let atributedTitle = NSMutableAttributedString(string: "Don't Have an Account?", attributes: ats)
        
        let boldAts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1), .font: UIFont.boldSystemFont(ofSize: 16)]
        atributedTitle.append(NSAttributedString(string: " Sign Up", attributes: boldAts))
        button.setAttributedTitle(atributedTitle, for: .normal)
        return button
    }()
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - helpers
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(logoImageView)
        logoImageView.centerX(inView: view)
        logoImageView.setDimensions(height: 60, width: 100)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 30)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stack.axis = .vertical
        stack.spacing = 20
        
        self.view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        self.view.addSubview(forgotPasswordButton)
        forgotPasswordButton.anchor(top: stack.bottomAnchor, right: view.rightAnchor, paddingTop: 8, paddingRight: 32)
        
        self.view.addSubview(loginButton)
        loginButton.anchor(top: forgotPasswordButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 32, paddingRight: 32)
        
        self.view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    }
}
