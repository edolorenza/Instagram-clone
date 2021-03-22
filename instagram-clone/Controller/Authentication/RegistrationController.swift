//
//  RegistrationController.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 19/03/21.
//

import UIKit

class RegistrationController: UIViewController{
    //MARK: - Properties
    
    private var viewModel = RegistrationViewModel()
    
    
    private let addPhotoButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .systemBlue
//        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
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
    
    private let fullnameTextField = CustomTextField(placeholder: "Fullname")
    private let usernameTextField = CustomTextField(placeholder: "Username")

    private let singUpButton: UIButton = {
        return UIButton.cekbutton(title: "Sign Up")
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstText: "Already have an account ?", secondText: "Log in")
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        return button
    }()
     
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    //MARK: - Actions
    
    @objc func handleShowLogIn(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }
        else if sender == passwordTextField {
            viewModel.password = sender.text
        }
        else if  sender == fullnameTextField {
            viewModel.fullname = sender.text
        }else if sender == usernameTextField {
            viewModel.username = sender.text
        }
        else {
            print("error")
        }
        updateForm()
    }
    
    
    //MARK: - helpers
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(addPhotoButton)
        addPhotoButton.centerX(inView: view)
        addPhotoButton.setDimensions(height: 120, width: 120)
        addPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 30)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField, usernameTextField, singUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        self.view.addSubview(stack)
        stack.anchor(top: addPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        self.view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
       
}

//MARK: - FormViewModelProtocol
extension RegistrationController: FormViewModel{
    func updateForm() {
        singUpButton.backgroundColor = viewModel.buttonBgColor
        singUpButton.isEnabled = viewModel.formIsValid
    }
}
