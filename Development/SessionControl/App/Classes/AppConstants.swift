//
//  AppConstants.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit

let kAppName : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? String()
let kAppBundleIdentifier : String = Bundle.main.bundleIdentifier ?? String()

enum DeviceType: String {
    case iOS = "iOS"
    case android = "android"
}

let emptyJsonString = "{}"

struct SCSettings {
    
    static let cornerRadius: CGFloat = 5
    static let borderWidth: CGFloat = 1
    static let shadowOpacity: Float = 0.4
    static let tableViewMargin: CGFloat = 50
    
    static let nameLimit = 20
    static let emailLimit = 70
    static let passwordLimit = 20
    
    static let footerMargin: CGFloat = 50
    static let profileImageSize = CGSize.init(width: 400, height: 400)
    static let profileBorderWidth: CGFloat = 4
}

struct SCColor {
    
    static let appWhite = UIColor(named: "AppWhite")!
    static let appFont = UIColor(named: "AppFont")!
    static let appOrange = UIColor(named: "AppOrange")!
    static let appBackground = UIColor(named: "AppBackground")!
    static let appClear = UIColor.clear
    static let appSelected = UIColor(named: "AppSelected")!
    static let appBlack = UIColor.black
    static let pending = UIColor(named: "Pending")!
    static let approved = UIColor(named: "Approved")!
    static let declined = UIColor(named: "Declined")!
    static let appLightGray = UIColor.lightGray
}

struct SCFont {
    
    static let defaultRegularFontSize: CGFloat = 20.0
    static let zero: CGFloat = 0.0
    static let reduceSize: CGFloat = 3.0
    static let increaseSize : CGFloat = 2.0
    
    //"family: Poppins"
    static func poppinsBold(size: CGFloat?) -> UIFont {
        return UIFont(name: "Poppins-Bold", size: size ?? defaultRegularFontSize)!
    }
    
    static func poppinsLight(size: CGFloat?) -> UIFont {
        return UIFont(name: "Poppins-Light", size: size ?? defaultRegularFontSize)!
    }
    
    static func poppinsMedium(size: CGFloat?) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: size ?? defaultRegularFontSize)!
    }
    
    static func poppinsRegular(size: CGFloat?) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size ?? defaultRegularFontSize)!
    }
    
    static func poppinsSemiBold(size: CGFloat?) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: size ?? defaultRegularFontSize)!
    }
}

struct SCImageName {
    
    static let background = "background"
    static let iconEmail = "icon_email"
    static let iconBirthdate = "icon_birthdate"
    static let iconGender = "icon_gender"
    static let iconPassword = "icon_password"
    static let iconChecked = "icon_checked"
    static let iconUnchecked = "icon_unchecked"
    static let iconUser = "icon_user"
    
    static let iconTransparent = "icon_transparent"
    static let iconDarkBackground = "icon_dark_background"
    static let iconCamera = "icon_camera"
    static let iconHome = "icon_home"
    static let iconHomeSelected = "icon_home_sel"
    static let iconSession = "icon_session"
    static let iconSessionSelected = "icon_session_sel"
    static let iconMessages = "icon_messages"
    static let iconMessagesSelected = "icon_messages_sel"
    static let iconNotification = "icon_notification"
    static let iconNotificationSelected = "icon_notification_sel"
    static let iconProfile = "icon_profile"
    static let iconProfileSelected = "icon_profile_sel"
    
    static let iconPlaceholder = "icon_placeholder"
    
    static let iconAccountInformation = "icon_info"
    static let iconPaymentMethods = "icon_payment_method"
    static let iconChangePassword = "icon_change_password"
    static let iconAllowLocation = "icon_allow_location"
    static let iconAllowNotification = "icon_allow_notification"
    static let iconSwitchToStudioProfile = "icon_info"
    static let iconTermsAndCondition = "icon_terms_condition"
    static let iconCancellationPolicy = "icon_cancellation_policy"
    static let iconLogout = "icon_sign_out"
    static let iconDisclosureIndicator = "icon_disclosure_indicator"
    
    static let permissionLocation = "permission_location"
    static let permissionNotification = "permission_notification"
    
//  MARK:- Studio Profile Icons
    
    static let iconStudioName = "person"
    static let iconAddress = "address"
    static let iconPhoneNumber = "phone"
    static let iconStudioCredits = "card"
    static let iconStudioGenres = "dj"
    static let iconDownArrow = "drop"
    static let iconCross = "cross"
//    static let iconUploadImage = "drop"
    
}
