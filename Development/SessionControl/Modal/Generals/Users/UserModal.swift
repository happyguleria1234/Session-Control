//
//  UserModal.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import Foundation

// MARK: - UserModal
struct UserModal: Codable {
    
    let userID, firstname, lastname, email: String?
    let password, image, creationDate, emailVerification: String?
    let emailAccessToken, userAccessToken, disable: String?
    let deviceToken, deviceType: String?
    let bio: String?
    let facebookID, googleID, appleID: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case firstname, lastname, email, password, image
        case creationDate = "creation_date"
        case emailVerification = "email_verification"
        case emailAccessToken = "email_access_token"
        case userAccessToken = "user_access_token"
        case facebookID = "facebookId"
        case disable
        case deviceToken = "device_token"
        case deviceType = "device_type"
        case bio = "description"
        case googleID = "googleId"
        case appleID = "appleId"
    }
    
    var fullName: String {
        var name: String = String()
        if let firstName = firstname {
            name = name.appending(firstName)
            if lastname != nil && lastname?.isEmpty == false {
                name = name.appending(" ")//space
            }
        }
        if let lastName = lastname {
            name = name.appending(lastName)
        }
        return name
    }
    
    var isSocialLogin: Bool {
        if let facebookId = facebookID, facebookId.isEmpty == false {
            return true
        }
        if let googleId = googleID, googleId.isEmpty == false {
            return true
        }
        if let appleId = appleID, appleId.isEmpty == false {
            return true
        }
        return false
    }
}

// MARK: ProjectModal convenience initializers and mutators

extension UserModal {
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UserModal.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

