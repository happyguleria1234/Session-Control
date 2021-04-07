//
//  RequestModal.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 3/12/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import Foundation

// MARK: - RequestModal
struct RequestModal: Codable {
    
    let requestID, userID, name, photo: String?
    let status, createDate, updateTime: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case requestID = "request_id"
        case userID = "user_id"
        case name, photo, status
        case createDate = "create_date"
        case updateTime = "update_time"
        case image
    }
}

// MARK: RequestModal convenience initializers and mutators

extension RequestModal {
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RequestModal.self, from: data)
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

