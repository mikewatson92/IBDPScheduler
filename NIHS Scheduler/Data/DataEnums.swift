//
//  DataEnums.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import Foundation

enum Group: String, Identifiable, CaseIterable, Codable, Hashable {
    case none = ""
    case one = "1 - Language A"
    case two = "2 - Language B"
    case three = "3 - Social"
    case four = "4 - Sciences"
    case five = "5 - Math"
    case six = "6 - Art"
    
    var id: Self { self }
}

enum Location: Codable, Hashable {
    case ALL1
    case ALL2
    case R106
    case R306
    case R300
    case scienceLab
    case MPR5
    case MPR6
}

enum Period: String, Codable, CaseIterable, Identifiable, Hashable {
    case P1 = "P1", P2 = "P2", P3 = "P3", P4 = "P4", P5 = "P5", P6 = "P6", P7 = "P7", P8 = "P8"
    
    var id: Self { self }
}

enum Grade: String, Identifiable, CaseIterable, Codable, Hashable {
    case None = "None", PreIB = "Pre IB", DP1 = "DP 1", DP2 = "DP 2"
    
    var id: Self { self }
}

enum Day: String, Codable, CaseIterable, Identifiable, Hashable {
    case Mon = "Mon", Tues = "Tue", Wed = "Wed", Thurs = "Thu", Fri = "Fri"
    
    var id: Self { self }
}
