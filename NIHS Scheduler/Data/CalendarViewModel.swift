//
//  CalendarViewModel.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import Foundation

struct CalendarViewModel: Identifiable, Equatable, Hashable, Codable {
    var id = UUID().uuidString
    var day: Day?
    var period: Period?
    var items: [ScheduleItem] {
        willSet {
            for var item in items {
                item.day = day
                item.period = period
            }
        }
    }
}
