//
//  SignUpController.swift
//  Bfood
//
//  Created by samer on 7/28/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
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
    let userTextField : SMSTextField = {
       let sms = SMSTextField()
        sms.placeholder = "UserName"
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
        b.setTitle("SignUp", for: .normal)
        b.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        b.layer.cornerRadius = 50
        b.isEnabled = false
    return b
    }()
    let alreadyHaveAccButton : UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = .systemBackground
        let attText = NSMutableAttributedString(string: "You already have account ? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor.systemGray2])
        attText.append(NSMutableAttributedString(string: "LogIn.", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.4518701434, green: 0.8224311471, blue: 0.09167806059, alpha: 1) ]))
        b.setAttributedTitle(attText, for: .normal)
        b.addTarget(self, action: #selector(alreadyHaveAccAction), for: .touchUpInside)
    return b
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        
        
        setupLayouts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
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
        let fieldsStack = CustomStackView(arrangedSubviews: [emailTextField,userTextField,passwordTextField], spacing: 10, axis: .vertical, dis: .fillEqually)
        view.addSubview(fieldsStack)
        fieldsStack.anchor(top: imageContainer.bottomAnchor, paddingTop: 30, bottom: nil, paddingBottom: 0, leading: view.leadingAnchor, paddingLeft: 30, trailing: view.trailingAnchor, paddingRight: 30, width: 0, height: 180)
        
        
        //Button
        view.addSubview(signUpButtom)
        signUpButtom.centerXInSuperview()
        signUpButtom.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 40).isActive = true
        signUpButtom.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signUpButtom.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(alreadyHaveAccButton)
        alreadyHaveAccButton.anchor(top: nil, paddingTop: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10, leading: view.leadingAnchor, paddingLeft: 0, trailing: view.trailingAnchor, paddingRight: 0, width: 0, height: 30)
        
    }

    @objc private func signUpAction(){
        
        guard let email = emailTextField.text else {return}
        guard let username = userTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("Error in creating user : ",err)
                return
            }
            guard let uid = res?.user.uid else { return }
            let dataArray:[String: Any] = ["UserName": username]
            
            let ref = Database.database().reference().child("Users").child(uid)
            ref.updateChildValues(dataArray)
            
            self.dismiss(animated: true, completion: nil)
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? BaseTabBarVController else { return }
            mainTabBarController.setupNavController()
        }
        
    }
    @objc private func alreadyHaveAccAction(){
        navigationController?.pushViewController(LoginController(), animated: true)
    }

    
    //MARK: //--------------changing button color depending on text fields---------------
    @objc private func handleTextInputChange()
    {
        if userTextField.text == "" || passwordTextField.text == "" || emailTextField.text == ""
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
