//
//  InputManager.swift
//  ios-cantact-manager
//
//  Created by J.E on 2022/12/21.
//

import Foundation

struct InputManager {
    private let inputInfoMessage = "연락처 정보를 입력해주세요 : "
    private let splitInputCount = 3
    private let hyphenCount = 2

    func parseUserInput() throws -> [String] {
        print(inputInfoMessage, terminator: "")
        
        let input = readLine()
        guard let input = input, input != "" else {
            throw InputError.invalidInput
        }
        let splitInput = input.components(separatedBy: "/").map {
            $0.replacingOccurrences(of: " ", with: "")
        }
        guard splitInput.count == splitInputCount else {
            throw InputError.invalidInput
        }
        
        return splitInput
    }
    
    func checkUserInput(_ name: String, _ age: String, _ tel: String) throws {
        let ageRegex = "^[0-9]{1,3}$"
        let ageRegexTest = NSPredicate(format: "SELF MATCHES %@", ageRegex)
        guard ageRegexTest.evaluate(with: age) else {
            throw InputError.invalidAge
        }
        
        guard (tel.filter { $0 == "-" }).count == hyphenCount else {
            throw InputError.invalidTel
        }
        let filteredTel = tel.filter { $0 != "-" }
        let telRegex = "^[0-9]{9,}$"
        let telRegexTest = NSPredicate(format: "SELF MATCHES %@", telRegex)
        guard telRegexTest.evaluate(with: filteredTel) else {
            throw InputError.invalidTel
        }
    }
}
