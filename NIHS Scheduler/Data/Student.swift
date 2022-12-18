//
//  Student.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import Foundation

struct Student: Identifiable, Codable, Hashable {
    static func == (lhs: Student, rhs: Student) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    let firstName: String
    let lastName: String
    let grade: Grade

}
