//
//  UserInfo.swift
//  SignUp
//
//  Created by COMATOKI on 2018-06-08.
//  Copyright © 2018 COMATOKI. All rights reserved.
//

import Foundation


class UserInformation{
    static let shared:UserInformation = UserInformation()
    
    var userId:String?
    var userPw:String?
    var userPhone:String?
    var userBirth:String?
    var userIntroTextView:String?
    var isImageSet:Bool = false
}
