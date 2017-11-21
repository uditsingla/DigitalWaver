//
//  Validations.swift
//  DigitalWaiver
//
//  Created by Abhishek Singla on 04/09/17.
//  Copyright © 2017 Sourcefuse. All rights reserved.
//

import Foundation

class Validations {
    // MARK: Strings
    
    static func validateLoginCredentials(email : String, password : String) -> String{
        var alertMessage = ""
        let emailValidationMsg = validateEmail(email: email)
        if(!emailValidationMsg.isEmpty){
            alertMessage = emailValidationMsg
        }
        else if (password.isEmpty){
            alertMessage = .strEmptyPasswordAlert
        }
        return alertMessage
        
    }
    
    static func validateEmail(email: String) ->String{
        var alertMessage = ""
        if(email.isEmpty){
            alertMessage = .strEmptyEmailAlert
        }
        else if (!isValidEmail(testStr: email)){
            alertMessage = .strValidEmailAlert
        }
        return alertMessage
    }
    
    static func validateForgotPasswordCredentials(field: String) ->String{
        var alertMessage = ""
        if(field.isEmpty){
            alertMessage = .strEmptyEmailPhoneAlert
        }
        return alertMessage
    }
    
    static func validateSignUpCredentials(fullName : String, email : String, address : String, password : String, confirmPassword : String) -> String{
        
        var alertMessage : String = ""
        let emailValidationMsg = validateEmail(email: email)
        
        if fullName.isEmpty{
            alertMessage = .strEmptyFirstNameAlert
        }
        else if(!emailValidationMsg.isEmpty){
            alertMessage = emailValidationMsg
        }
        else if address.isEmpty{
            alertMessage = .strEmptyAddressAlert
        }
        else if (password.isEmpty){
            alertMessage = .strEmptyPasswordAlert
        }
        else if (confirmPassword.isEmpty){
            alertMessage = .strEmptyConfirmPasswordAlert
        }
        else if (password != confirmPassword){
            alertMessage = .strPasswordsDoNotMatchAlert
        }
        return alertMessage
        
    }
    
    static func validateAddGroup(name : String, participants : String) -> String{
        
        var alertMessage : String = ""
        
        if name.isEmpty{
            alertMessage = .strEmptyGroupName
        }
        else if participants.isEmpty{
            alertMessage = .strParticipants
        }
        
        return alertMessage
        
    }
    
    static func validateAddParticipants(fullName : String, email : String, phoneNo : String) -> String{
        
        var alertMessage : String = ""
        let emailValidationMsg = validateEmail(email: email)
        
        if fullName.isEmpty{
            alertMessage = .strEmptyFirstNameAlert
        }
        else if(!emailValidationMsg.isEmpty){
            alertMessage = emailValidationMsg
        }
        else if phoneNo.isEmpty{
            alertMessage = .strEmptyPhoneNumberAlert
        }
        else if (phoneNo.characters.count < 11){
            alertMessage = .strIncorrectPhoneNo
        }

        return alertMessage
        
    }
    
    static func validateProfileCredentials(firstName : String, lastName : String, zipCode : String, sex : String, age : String, aboutYou : String, havePets : Bool, petSelectionMade : Bool, anyPetSelected: Bool, profession : String, haveKids : Bool, kidsSelectionMade : Bool, anyKidsRangeSelected : Bool, howHeard : String, heardFromText : String) -> String{
        var alertMessage : String = ""
        if(firstName.isEmpty){
            alertMessage = .strEmptyFirstNameAlert
        }
        else if zipCode.isEmpty{
            alertMessage = .strEmptyZipcodeAlert
        }
        else if sex == "Gender"{
            alertMessage = .strEmptySexAlert
        }
        else if age == "Age"{
            alertMessage = .strEmptyAgeAlert
        }
        else if profession == "Occupation" {
            alertMessage = .strEmptyProfessionAlert
        }
        else if !petSelectionMade{
             alertMessage = .strPetSelectionMissingAlert
        }
        else if havePets && (!anyPetSelected) {
            alertMessage = .strEmptyPetAlert
        }
        else if !kidsSelectionMade{
            alertMessage = .strKidSelectionMissingAlert
        }
        else if haveKids &&  (!anyKidsRangeSelected){
            alertMessage = .strEmptyKidsAgeAlert
        }
        else if aboutYou.isEmpty{
            alertMessage = .strEmptyAboutYouAlert
        }
        else if howHeard == "How did you hear about FlipperSplash?" {
            alertMessage = .strEmptyHowHeardAlert
        }        
        return alertMessage
        
    }
    
    static func validateChangePasswordCredentials(newPassword : String, confirmPassword : String) -> String{
        var alertMessage : String = ""
        if newPassword.isEmpty{
            alertMessage = .strEmptyNewPasswordAlert
        }
        else if confirmPassword.isEmpty{
            alertMessage = .strEmptyConfirmPasswordAlert
        }
        else if newPassword != confirmPassword{
            alertMessage = .strPasswordsDoNotMatchAlert
        }
        return alertMessage
    }
    
    static func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    static func validatePhone(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
}

