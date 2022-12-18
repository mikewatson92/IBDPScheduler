//
//  Subject.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import Foundation

struct Subject: Identifiable, Codable, Hashable {
    static func == (lhs: Subject, rhs: Subject) -> Bool {
        lhs.id == rhs.id
    }
    var id = UUID().uuidString
    var numberOfLessonsStr: String {
        String(numberOfLessons)
    }
    var numberOfLessons = 0
    var group: Group
    var grade: Grade
    var name: String
    var level: String
    var label: String {
        return "\(grade) - \(name) \(level) (\(teacher.lastName))"
    }
    var teacher: Teacher
    var roster: [Student]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(teacher)
        /*
        hasher.combine(numberOfLessons)
        hasher.combine(group)
        hasher.combine(grade)
        hasher.combine(name)
        hasher.combine(level)
         
         */
    }

}
