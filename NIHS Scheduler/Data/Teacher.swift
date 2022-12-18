//
//  Teacher.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import Foundation
import SwiftUI

struct Teacher: Identifiable, Equatable, Comparable, Codable, Hashable {
    
    init(firstName: String, lastName: String, homeRoom: Grade) {
        self.firstName = firstName
        self.lastName = lastName
        self.homeRoom = homeRoom
    }
    
    var id = UUID()
    var firstName: String
    var lastName: String
    var homeRoom: Grade
    var monday: Int = 0
    var tuesday: Int = 0
    var wednesday: Int = 0
    var thursday: Int = 0
    var friday: Int = 0
    var mondayStr: String {
        String(monday)
    }
    var tuesdayStr: String {
        String(tuesday)
    }
    var wednesdayStr: String {
        String(wednesday)
    }
    var thursdayStr: String {
        String(thursday)
    }
    var fridayStr: String {
        String(friday)
    }
    
    static func < (lhs: Teacher, rhs: Teacher) -> Bool {
        return lhs.lastName < rhs.lastName
    }
    
    static func == (lhs: Teacher, rhs: Teacher) -> Bool {
        return lhs.lastName == rhs.lastName && lhs.firstName == rhs.firstName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        /*
        hasher.combine(firstName)
        hasher.combine(lastName)
        hasher.combine(homeRoom)
        */
    }
}
