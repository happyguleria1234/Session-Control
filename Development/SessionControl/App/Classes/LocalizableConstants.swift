//
//  LocalizableConstant.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit

struct LocalizableConstants {
    
    struct SuccessMessage {
        
        static let verificationMailSent = "verification_mail_sent"
        static let mailNotVerifiedYet = "mail_not_verified_yet"
        static let newPasswordSent = "new_password_sent"
        static let profileUpdated = "profile_updated"
        static let passwordChanged = "password_changed"
        static let addRequestSent = "add_request_sent"
    }
    
    struct Error {
        
        static let noNetworkConnection = "no_network_connection"
        static let sessionExpired = "session_expired"
        static let inProgress = "in_progress"
    }
    
    struct ValidationMessage {
        
        //singup
        static let enterFirstName = "enter_first_name"
        static let enterLastName = "enter_last_name"
        static let selectBirthDate = "select_birth_date"
        static let selectGender = "select_gender"
        static let enterEmail = "enter_email"
        static let enterValidEmail = "enter_valid_email"
        static let enterMobileNumber = "enter_mobile"
        static let enterValidMobileNumber = "enter_valid_mobile"
        static let enterPassword = "enter_password"
        static let enterValidPassword = "enter_valid_password"
        
        //change password
        static let enterNewPassword = "enter_new_password"
        static let enterValidNewPassword = "enter_valid_new_password"
        static let enterRetypePassword = "enter_retype_password"
        static let enterValidRetypePassword = "enter_valid_retype_password"
        static let oldNewPasswordNotSame = "old_new_password_not_same"
        static let NewRetypePasswordNotMatch = "new_retype_password_not_match"
        
        //add request
        static let enterName = "enter_name"
        static let selectAddRequestPhoto = "select_add_request_photo"
        
        //signout
        static let confirmLogout = "confirm_logout"
    }
    
    struct Controller {
        
        struct Pages {
            
            static let pullMore = "pull_more"
            static let releaseToRefresh = "release_to_refresh"
            static let updating = "updating"
        }
        
        struct Home {
            static let title = "SC"
        }
        
        struct Sessions {
            
            static let title = "sessions"
            static let pending = "pending"
            static let confirmed = "confirmed"
            static let moreInfo = "more_info"
            static let payNow = "pay_now"
        }
        
        struct Messages {
            
            static let title = "messages"
        }
        
        struct Notifications {
            
            static let title = "notifications"
            static let noRecordsFound = "no_notifications_entry_found"
        }
        
        struct Profile {
            
            static let accountInformation = "account_information"
            static let paymentMethods = "payment_method"
            static let changePassword = "change_password"
            static let allowLocation = "allow_location"
            static let allowNotification = "allow_notification"
            static let switchToStudioProfile = "switch_to_studio"
            static let switchToArtistProfile = "switch_to_artist"
            static let termsAndCondition = "terms_and_condition"
            static let cancellationPolicy = "cancellation_policy"
            static let logout = "sign_out"
        }
        
        struct EditProfile {
            
            static let title = "edit_profile"
        }
        
        struct Permissions {
            
            static let locationPermissionTitle = "location_permission_title"
            static let locationPermissionDescription = "location_permission_description"
            static let notificationPermissionTitle = "notification_permission_title"
            static let notificationPermissionDescription = "notification_permission_description"
        }
    }
}
