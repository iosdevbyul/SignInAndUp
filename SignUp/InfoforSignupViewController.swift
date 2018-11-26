//
//  InfoforSignupViewController.swift
//  SignUp
//
//  Created by COMATOKI on 2018-06-05.
//  Copyright © 2018 COMATOKI. All rights reserved.
//

import UIKit

class InfoforSignupViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate {
    
    //Properties
    
    //To pick a image to set a user's profile
    @IBOutlet weak var profileImage: UIImageView!
    
    //Textfields to gether text-based user's information
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var userIntroTextView: UITextView!
    
    //A button - will be enabled or disabled
    @IBOutlet weak var nextButton:UIButton!
    
    //Referenced by https://newfivefour.com/swift-ios-choose-an-image-UIImagePickerController.html
    //Define an imagePicker to choose an image
    lazy var imagePicker:UIImagePickerController = {
        let ip:UIImagePickerController = UIImagePickerController()
        ip.sourceType = .photoLibrary
        ip.delegate = self
        ip.allowsEditing = true
        return ip
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Delegate to make a button enabled or disabled
        self.userIdTextField.delegate = self
        self.passwordTextField.delegate = self
        self.checkPasswordTextField.delegate = self
        
        //Referenced by https://stackoverflow.com/questions/27880607/how-to-assign-an-action-for-uiimageview-object-in-swift/27880690
        //UITapGestureRecognizer for imageView named profileImage
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoPicturePicker(_:)))
        tapGestureRecognizer.delegate = self
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        profileImage.isUserInteractionEnabled = true
        
        //UITapGestureRecognizer to make a keyboard disappear
        let tapGestureRecognizerforView = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        tapGestureRecognizerforView.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizerforView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Check user's information to set the button's state
        checkUserInfoValidation()
    }
    

    //go to RootViewController
    @IBAction func cancelSignup(_ sender: Any) {
        clearAllComponent()
        gotoBack()
    }

    func clearAllComponent(){
        userIdTextField.text = ""
        passwordTextField.text = ""
        checkPasswordTextField.text = ""
        userIntroTextView.text = ""
    }
    
    func gotoBack(){
        clearAllComponent()
        navigationController?.popToRootViewController(animated: true)
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        checkUserInfoValidation()
    }
    
    func checkUserInfoValidation(){
        
        //==========  Condition 1    ==========
        //Compare Password textfilds
        if((passwordTextField.text != checkPasswordTextField.text)){
            nextButton.isEnabled = false
            return
        }
        
        //==========  Condition 2    ==========
        //check all components
        if(userIdTextField.text == "")||(passwordTextField.text == "")||(checkPasswordTextField.text == "")||(userIntroTextView.text == ""){
            nextButton.isEnabled = false
            return
        }

        //==========  Condition 3    ==========
        //check the profile image
        if !(UserInformation.shared.isImageSet){
            nextButton.isEnabled = false
            return
        }
        
        nextButton.isEnabled = true
    }

    //store dates before go to next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        UserInformation.shared.userId = userIdTextField.text
        UserInformation.shared.userPw = passwordTextField.text
        UserInformation.shared.userIntroTextView = userIntroTextView.text
    }
    
    //from ImagePicker Delegate
    //An action after a user chooses a image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        //use the image
        profileImage.image = chosenImage
        UserInformation.shared.isImageSet = true
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //Methods - UITapGestureRecognizer
    @objc func gotoPicturePicker(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @objc func hideKeyboard(_ sender:UITapGestureRecognizer){
        self.view.endEditing(true)
        checkUserInfoValidation()
    }
    
}
