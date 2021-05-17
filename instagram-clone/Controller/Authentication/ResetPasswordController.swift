//
//  ResetPasswordController.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 17/05/21.
//

import UIKit

protocol ResetPasswordControllerDelegate: AnyObject {
    func controllerDidResetPasswordLink(_ controller: ResetPasswordController)
}

class ResetPasswordController: ViewController{
    //MARK: - Properties
    private var viewModel = ResetPasswordViewModel()
    weak var delegate: ResetPasswordControllerDelegate?
    
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
    
    private let resetPasswordButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitleColor(.white, for: .normal)
        button.setHeight(50)
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 5.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle("Reset Password", for: .normal)
        button.addTarget(self, action: #selector(handleResetButtonTapped), for: .touchUpInside)
        return button
    }()
        
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .blue
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    //MARK: - API
    func resetPassword() {
        guard let email = emailTextField.text else { return }
        self.showLoader(true)
        AuthService.resetPassword(withEmail: email) { error in
            if let error = error {
                self.showMessage(withTitle: "Error", message: error.localizedDescription)
                self.showLoader(false)
                return
        }
        self.delegate?.controllerDidResetPasswordLink(self)
    }
}
    //MARK: - Actions
    @objc func handleResetButtonTapped() {
        resetPassword()
        
        
    }

    @objc func handleBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
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
        
        self.view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        self.view.addSubview(logoImageView)
        logoImageView.centerX(inView: view)
        logoImageView.setDimensions(height: 60, width: 100)
        logoImageView.anchor(top: backButton.bottomAnchor, paddingTop: 20)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, resetPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        self.view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}


//MARK: - FormViewModelProtocol
extension ResetPasswordController: FormViewModel{
    func updateForm() {
        resetPasswordButton.backgroundColor = viewModel.buttonBgColor
        resetPasswordButton.isEnabled = viewModel.formIsValid
    }
}

