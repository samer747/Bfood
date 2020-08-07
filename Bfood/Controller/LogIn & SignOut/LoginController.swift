//
//  LoginController.swift
//  Bfood
//
//  Created by samer on 7/28/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    //imageView
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "BfoodLogo")
        return iv
    }()
    
    //textfields
    let emailTextField : SMSTextField = {
       let sms = SMSTextField()
        sms.placeholder = "Email"
        sms.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return sms
    }()
    let passwordTextField : SMSTextField = {
       let sms = SMSTextField()
        sms.placeholder = "Password"
        sms.isSecureTextEntry = true
        sms.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return sms
    }()
    
    //Button
    let signUpButtom : UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Login", for: .normal)
        b.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        b.setTitleColor(.white, for: .normal)
        b.isEnabled = false
        b.addTarget(self, action: #selector(LoginAction), for: .touchUpInside)
        b.layer.cornerRadius = 50
    return b
    }()
    let alreadyHaveAccButton : UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = .systemBackground
        let attText = NSMutableAttributedString(string: "You Dont have account ? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor.systemGray2])
        attText.append(NSMutableAttributedString(string: "SignUp.", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.4518701434, green: 0.8224311471, blue: 0.09167806059, alpha: 1) ]))
        b.setAttributedTitle(attText, for: .normal)
        b.addTarget(self, action: #selector(dontHaveAccount), for: .touchUpInside)
    return b
    }()
    
        //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setupLayouts()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    
    private func setupLayouts()
    {
        //Image
        let imageContainer = UIView()
        imageContainer.addSubview(imageView)
        imageView.fillSuperview(padding: .init(top: 50, left: 40, bottom: 50, right: 60))
        view.addSubview(imageContainer)
        imageContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, leading: view.leadingAnchor, paddingLeft: 0, trailing: view.trailingAnchor, paddingRight: 0, width: 0, height: 200)
        
        
        //Stack
        let fieldsStack = CustomStackView(arrangedSubviews: [emailTextField,passwordTextField], spacing: 10, axis: .vertical, dis: .fillEqually)
        view.addSubview(fieldsStack)
        fieldsStack.anchor(top: imageContainer.bottomAnchor, paddingTop: 50, bottom: nil, paddingBottom: 0, leading: view.leadingAnchor, paddingLeft: 30, trailing: view.trailingAnchor, paddingRight: 30, width: 0, height: 130)
        
        
        //Button
        view.addSubview(signUpButtom)
        signUpButtom.centerXInSuperview()
        signUpButtom.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 40).isActive = true
        signUpButtom.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signUpButtom.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(alreadyHaveAccButton)
        alreadyHaveAccButton.anchor(top: nil, paddingTop: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10, leading: view.leadingAnchor, paddingLeft: 0, trailing: view.trailingAnchor, paddingRight: 0, width: 0, height: 30)
    }
    
    @objc private func LoginAction(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("Error in creating user : ",err)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? BaseTabBarVController else { return }
            mainTabBarController.setupNavController()
        }
    }
    @objc private func dontHaveAccount(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: //--------------changing button color depending on text fields---------------
    @objc private func handleTextInputChange()
    {
        if passwordTextField.text == "" || emailTextField.text == ""
        {
            signUpButtom.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }
        else
        {
            signUpButtom.backgroundColor = #colorLiteral(red: 0.4518701434, green: 0.8224311471, blue: 0.09167806059, alpha: 1)
            signUpButtom.isEnabled = true
        }
    }
    
}
