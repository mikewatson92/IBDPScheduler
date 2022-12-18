//
//  ModelData.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import Foundation

final class ModelData: ObservableObject, Codable, Hashable {
    static func == (lhs: ModelData, rhs: ModelData) -> Bool {
        lhs.teachers == rhs.teachers && lhs.students == rhs.students && lhs.subjects == rhs.subjects && lhs.scheduleItems == rhs.scheduleItems
    }
    
    
    @Published var teachers: [Teacher] = []
    @Published var students: [Student] = []
    @Published var subjects: [Subject] = []
    @Published var scheduleItems: [ScheduleItem] = []
    @Published var calendarModels: [CalendarViewModel] = [
        CalendarViewModel(day: .Mon, period: .P1, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Tues, period: .P1, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Wed, period: .P1, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Thurs, period: .P1, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Fri, period: .P1, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Mon, period: .P2, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Tues, period: .P2, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Wed, period: .P2, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Thurs, period: .P2, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Fri, period: .P2, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Mon, period: .P3, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Tues, period: .P3, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Wed, period: .P3, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Thurs, period: .P3, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Fri, period: .P3, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Mon, period: .P4, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Tues, period: .P4, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Wed, period: .P4, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Thurs, period: .P4, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Fri, period: .P4, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Mon, period: .P5, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Tues, period: .P5, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Wed, period: .P5, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Thurs, period: .P5, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Fri, period: .P5, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Mon, period: .P6, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Tues, period: .P6, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Wed, period: .P6, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Thurs, period: .P6, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Fri, period: .P6, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Mon, period: .P7, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Tues, period: .P7, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Wed, period: .P7, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Thurs, period: .P7, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Fri, period: .P7, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Mon, period: .P8, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Tues, period: .P8, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Wed, period: .P8, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Thurs, period: .P8, items: [ScheduleItem(name: nil)]),
        CalendarViewModel(day: .Fri, period: .P8, items: [ScheduleItem(name: nil)])
    ]
    
    init() { }
    
    enum CodingKeys: String, CodingKey, Hashable {
        case teachers = "Teachers"
        case students = "Students"
        case subjects = "Subjects"
        case lessons = "Lessons"
        case rooms = "Rooms"
        case scheduleItems = "Schedule Items"
        case calendarModels = "Calendar Models"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(teachers, forKey: .teachers)
        try container.encode(students, forKey: .students)
        try container.encode(subjects, forKey: .subjects)
        try container.encode(scheduleItems, forKey: .scheduleItems)
        try container.encode(calendarModels, forKey: .calendarModels)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let teachers = try container.decode([Teacher].self, forKey: .teachers)
        let students = try container.decode([Student].self, forKey: .students)
        let subjects = try container.decode([Subject].self, forKey: .subjects)
        let scheduleItems = try container.decode([ScheduleItem].self, forKey: .scheduleItems)
        let calendarModels = try container.decode([CalendarViewModel].self, forKey: .calendarModels)
        self.teachers = teachers
        self.students = students
        self.subjects = subjects
        self.scheduleItems = scheduleItems
        self.calendarModels = calendarModels
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(teachers)
        hasher.combine(students)
        hasher.combine(subjects)
        hasher.combine(scheduleItems)
        hasher.combine(calendarModels)
    }

}
