//
//  DetailInfoForSignupViewController.swift
//  SignUp
//
//  Created by COMATOKI on 2018-06-05.
//  Copyright © 2018 COMATOKI. All rights reserved.
//

import UIKit

class DetailInfoForSignupViewController: UIViewController,UITextFieldDelegate, UIGestureRecognizerDelegate {

    //Properties
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var labelforBirth: UILabel!
    @IBOutlet weak var joinButton:UIButton!
    
    //Set DateFormatter to make a format for date that the user picks
    var dateFormatter:DateFormatter = {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter
    }()
    
    var isPickerValueChanged:Bool = false
    var dateString:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserInfoValidation()
        // Do any additional setup after loading the view.
        
        //UITapGestureRecognizer to make a keyboard disappear
        let tapGestureRecognizerforView = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        tapGestureRecognizerforView.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizerforView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        guard let phone = UserInformation.shared.userPhone else {
            return
        }
        
        guard let date = UserInformation.shared.userBirth else {
            return
        }
        
        isPickerValueChanged = true
        
        phoneTextField.text = phone
        labelforBirth.text = date
        
        //open func string(from date: Date) -> String
        //open func date(from string: String) -> Date?
        let dateString:Date = dateFormatter.date(from: date)!

        setPickedDate(dateString)
        
        checkUserInfoValidation()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickJoinButton(_ sender: Any) {
        UserInformation.shared.userPhone = phoneTextField.text
        UserInformation.shared.userBirth = dateString
        navigationController?.popToRootViewController(animated: true)

    }
    
    
    @IBAction func gotoBacktoModifyUserInfo(_ sender: Any) {
        if(phoneTextField.text != ""){
            UserInformation.shared.userPhone = phoneTextField.text
        }
        if(labelforBirth.text != ""){
            UserInformation.shared.userBirth = labelforBirth.text
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelSignUp(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func datePickertoChooseBirth(_ sender: Any) {
        isPickerValueChanged = true
        setPickedDate(birthDatePicker.date)
        checkUserInfoValidation()
    }
    
    func setPickedDate(_ pickedDate:Date){
        let date:Date = pickedDate
        dateString = dateFormatter.string(from: date)
        labelforBirth.text = dateString
        birthDatePicker.date = date
    }
    
    func checkUserInfoValidation(){
        if(phoneTextField.text == "")||(!isPickerValueChanged){
            joinButton.isEnabled = false
            return
        }
        if(labelforBirth.text == ""){
            joinButton.isEnabled = false
            return
        }
        
        joinButton.isEnabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkUserInfoValidation()
    }
    
    @objc func hideKeyboard(_ sender:UITapGestureRecognizer){
        checkUserInfoValidation()
        self.view.endEditing(true)
    }
}
