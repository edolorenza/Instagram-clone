//
//  LoginController.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 19/03/21.
//

import UIKit

class LoginController: ViewController{
    //MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    private let logoImageView: UIImageView =  {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "instagramLogo")
        return iv
    }()
    private let emailTextField: CustomTextField =  {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: CustomTextField =  {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
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
        return UIButton.cekbutton(title: "Login")
    }()
        
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstText: "Don't have an account ?", secondText: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    //MARK: - Actions
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }
        else{
            viewModel.password = sender.text
        }
        updateForm()
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
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    
}

//MARK: - FormViewModelProtocol

extension LoginController: FormViewModel{
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBgColor
        loginButton.isEnabled = viewModel.formIsValid
    }
}


