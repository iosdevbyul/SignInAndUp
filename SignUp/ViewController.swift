//
//  ViewController.swift
//  SignUp
//
//  Created by COMATOKI on 2018-06-05.
//  Copyright © 2018 COMATOKI. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate,UITextFieldDelegate {

    @IBOutlet weak var logoImage: UIImageView!
    
    //To store datas into Singleton named UserInformation
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //UITapGestureRecognizer to make a keyboard disappear
        let tapGestureRecognizerforView = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        tapGestureRecognizerforView.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizerforView)
        
        //set delegate and tag to textfields to use a method named textFieldShouldReturn
        idTextField.delegate = self
        pwTextField.delegate = self
        idTextField.tag = 0
        pwTextField.tag = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let id = UserInformation.shared.userId else {
            return
        }
        
        guard let pw = UserInformation.shared.userPw else{
            return
        }
        
        idTextField.text = id
        pwTextField.text = pw
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickSignInBtn(_ sender: Any) {
//        let alert:UIAlertController = UIAlertController(title: "Success", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
//       
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//        
//        self.present(alert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        idTextField.text = ""
        pwTextField.text = ""
    }
    
    @objc func hideKeyboard(_ sender:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    //Referenced by https://stackoverflow.com/questions/31766896/switching-between-text-fields-on-pressing-return-key-in-swift
    //To response when a user pushs testfield's return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            pwTextField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }

}

