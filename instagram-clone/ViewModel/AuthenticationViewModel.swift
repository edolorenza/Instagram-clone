//
//  AuthenticationViewModel.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 21/03/21.
//

import UIKit

protocol AuthenticatonViewModel {
    var formIsValid: Bool { get }
    var buttonBgColor: UIColor { get }
}

protocol FormViewModel {
   func updateForm()
}
struct LoginViewModel: AuthenticatonViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBgColor: UIColor {
        return formIsValid ? #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
}

struct RegistrationViewModel: AuthenticatonViewModel {
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBgColor: UIColor{
        return formIsValid ? #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
}
