//
//  contactManager.swift
//  ios-cantact-manager
//
//  Created by J.E on 2022/12/28.
//

import Foundation

struct ContactManager {
    var contactManageSystem = ContactManageSystem()
    
    mutating func run() {
        while !contactManageSystem.isFinished {
            do {
                let input = try contactManageSystem.deliverMenuInputValue()
                contactManageSystem.pipeInMenu(input)
                print()
            } catch {
                OutputManager.printMessage(.invalidMenu)
            }
        }
    }
}