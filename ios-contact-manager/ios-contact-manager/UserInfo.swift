//
//  UserInfo.swift
//  ios-contact-manager
//
//  Created by sei_dev on 12/22/22.
//

import Foundation

enum UserInfoParameters: String {
    case name = "이름"
    case age = "나이"
    case phone = "연락처"
    
    var regex: String {
        switch self {
        case .name:
            return "^[A-Za-z ]+$"
        case .age:
            return #"^\d{1,3}$"#
        case .phone:
            return #"^\d{2,3}-\d{3,4}-\d{4}$"#
        }
    }
    
    var error: IOError {
        return IOError.invalidProperty(parameter: self)
    }
}

struct UserInfo {
    let name: String
    let age: Int
    let phone: String
    
    init(name:String, age:String, phone: String) throws {
        do {
            let regexName = try name.matches(infoType: .name)
            self.name = regexName.components(separatedBy: " ").joined()
            guard let age = Int(try age.matches(infoType: .age)) else {
                throw IOError.invalidProperty(parameter: .age)
            }
            self.age = age
            self.phone = try phone.matches(infoType: .phone)
        } catch {
            throw error
        }
    }
    
    init(input: InfoInput) throws {
        try self.init(name: input.name, age: input.age, phone: input.phone)
    }
}

extension UserInfo: CustomStringConvertible {
    var description: String {
        return "\(self.age)세 \(self.name)(\(self.phone))"
    }
}

fileprivate extension String {
    func matches(infoType: UserInfoParameters) throws -> String {
        guard self ~= infoType.regex else {
            throw infoType.error
        }
        return self
    }
}