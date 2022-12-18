//
//  ScheduleItem.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import Foundation
import SwiftUI

struct ScheduleItem: Identifiable, Codable, Equatable, Hashable {
    static func == (lhs: ScheduleItem, rhs: ScheduleItem) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID().uuidString
    var name: String?
    var subject: Subject?
    var teacher: Teacher?
    var location: Location?
    var period: Period?
    var day: Day?
    var roster: [Student]?
    var color: Color {
        switch subject?.grade {
        case .PreIB:
            return Color.green.opacity(0.75)
        case .DP1:
            return Color.blue.opacity(0.75)
        case .DP2:
            return Color.yellow.opacity(0.75)
        default:
            return Color.clear
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        /*
        hasher.combine(name)
        hasher.combine(subject)
        hasher.combine(teacher)
        hasher.combine(location)
        hasher.combine(period)
        hasher.combine(day)
        hasher.combine(roster)
        */
    }
}
