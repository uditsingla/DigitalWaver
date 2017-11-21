//
//  Strings.swift
//  Flippersplash
//
//  Created by Deepak on 04/09/17.
//  Copyright © 2017 Sourcefuse. All rights reserved.
//

import Foundation

//All the user visible strings have been kept in this file, using an extension of String class
extension String {
    
    static let strAlert = "Alert"
    static let strError = "Error"
    static let strSuccess = "SUCCESS"
    
    //
    static let strVerificationSuccess = "Your email has been verified, Please login to continue"
    
    // MARK: ------------SIGN UP--------------
    static let strFirstName = "First Name*"
    static let strLastName = "Last Name*"
    static let strEmail = "Email*"
    static let strConfirmEmail = "Confirm Email*"
    static let strPassword = "Password*"
    static let strConfirmPassword = "Confirm Password*"
    static let strPhoneNumber = "Phone Number*"
    static let strReferralCode = "Have a Referral Code?"
    static let strTermsPolicy = "I agree to the Terms of Service and Privacy Policy"

    // MARK: -----------Validation strings----------
    static let strEmptyEmailAlert = "Please enter email"
    static let strEmptyEmailPhoneAlert = "Please enter Mobile Number or Email"
    static let strEmptyConfirmEmailAlert = "Please enter confirm email"
    static let strEmailsDoNotMatchAlert = "Email and Confirm email do not match"
    static let strEmptyPasswordAlert = "Please enter password"
    static let strEmptyConfirmPasswordAlert = "Please enter confirm password"
    static let strPasswordsDoNotMatchAlert = "Password and Confirm password do not match"
    static let strValidEmailAlert = "Please enter valid email"
    static let strEmptyFirstNameAlert = "Please enter name"
    static let strEmptyAddressAlert = "Please enter address"
    static let strEmptyPhoneNumberAlert = "Please enter phone number"
    static let strIncorrectPhoneNo = "Please enter correct phone number"
    static let strInValidPhoneNumberAlert = "Please enter valid phone number"
    static let strEmptyTermsPolicyAlert = "Please accept Terms of Service and Privacy Policy"
    static let strEmptyGroupName = "Please enter group name"
    static let strParticipants = "Please enter number of participants"


    //
    static let strEmptyNewPasswordAlert = "Please enter new password"
    static let strSuccessChangePassword = "Password changed successfully"
    
    //Signup success strings
    static let signUpSuccessTitle = "SIGN UP WAS SUCCESSFUL"
    static let signUpSuccessMessage = "A confirmation email has been sent to your email"
    static let signUpSuccessMessageWithoutEmailVerification = "Please login to continue"
    
    // MARK: -----------Create Profile Validations----------
    static let strEmptyZipcodeAlert = "Please enter zipcode"
    static let strEmptySexAlert = "Please select gender"
    static let strEmptyAgeAlert = "Please select age"
    static let strEmptyAboutYouAlert = "Please tell us about yourself"
    static let strEmptyPetAlert = "Please select type of pet(s) you have"
    static let strEmptyProfessionAlert = "Please select your occupation"
    static let strEmptyKidsAgeAlert = "Please tell us how old are your kids"
    static let strEmptyHowHeardAlert = "Please tell us how did you hear about FlipperSplash"
    static let strEmptyMediaAlert = "Please upload media kit"
    static let strPetSelectionMissingAlert = "Please tell us, do you have pets"
    static let strKidSelectionMissingAlert = "Please tell us, do you have kids"

    
    // MARK: -----------Profile Update/Create----------
    static let strProfileCreated = "Profile Created"
    static let strProfileUpdated = "Profile Updated"
    static let strImageUpdated = "Profile pic has been updated"
    static let strInteresetsUpdated = "Interests has been added/updated"
    static let strMoreInteresetsRequired = "Add at least three interests"
    static let strTellsUSAboutYou = "Tell us some fun facts about you, Hobbies, Bucket list, Clubs etc."
    static let strWordofMouth = "Word of Mouth"
    static let strOther = "Other"
    
     // MARK: -----------Login----------
     static let strVerifyEmail = "Please verify your email"
     static let strInvalidCredentials = "Invalid email or password"
    
    //My Gigs
    static let strMyGigs = "My Gigs"
    static let strPublicGigs = "Public Gigs"
    static let strFavourites = "Favourites"
    static let strArchived = "Archived"
    
    //Tasks
    static let strDueSoon = "Due Soon"
    static let strUpcomingTask = "Upcoming Task"
    static let strActive = "Active"
    static let strMarkAsDone = "Mark as Done"
    static let strAddNotes = "Add Notes"
    static let strDueToday = "Due Today"

    //Home
    static let strGigInvitations = "Gig Invitations"
    static let strPriorityTasks = "Priority Tasks"
    
    //

}

