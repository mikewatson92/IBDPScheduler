//
//  TeacherView.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import SwiftUI

struct TeacherView: View {
    @EnvironmentObject var model: ModelData
    @State private var selectedTeacherID: Teacher.ID?
    @State private var sortOrder = [KeyPathComparator(\Teacher.lastName)]
    
    var teacherData: [Teacher] {
        return model.teachers.sorted(using: sortOrder)
    }
    
    func removeTeacher() {
        model.teachers.removeAll(where: { $0.id == selectedTeacherID! })
        // Save data
        do {
            try FileManager().encodeToFile(name: "ModelData.json", content: model)
        } catch {
            print("Unable to save data!")
        }
    }
    
    func teacherDailyCount() {
        for teacher in model.teachers {
            let index = model.teachers.firstIndex(of: teacher)
            model.teachers[index!].monday = 0
            model.teachers[index!].tuesday = 0
            model.teachers[index!].wednesday = 0
            model.teachers[index!].thursday = 0
            model.teachers[index!].friday = 0
        }
        
        for scheduleItem in model.scheduleItems {
            if let index = model.teachers.firstIndex(of: scheduleItem.teacher!) {
                let itemIndex = model.calendarModels.firstIndex(where: { $0.items.contains(scheduleItem)})
                if model.calendarModels[itemIndex!].day != nil {
                    switch model.calendarModels[itemIndex!].day! {
                    case .Mon:
                        model.teachers[index].monday += 1
                    case .Tues:
                        model.teachers[index].tuesday += 1
                    case .Wed:
                        model.teachers[index].wednesday += 1
                    case .Thurs:
                        model.teachers[index].thursday += 1
                    case .Fri:
                        model.teachers[index].friday += 1
                    }
                }
            }
        }
    }
    
    var body: some View {
        Table(teacherData, selection: $selectedTeacherID, sortOrder: $sortOrder) {
            TableColumn("Last Name", value: \.lastName)
            TableColumn("First Name", value: \.firstName)
            TableColumn("Homeroom", value: \.homeRoom.rawValue)
            TableColumn("Monday", value: \.mondayStr)
            TableColumn("Tuesday", value: \.tuesdayStr)
            TableColumn("Wednesday", value: \.wednesdayStr)
            TableColumn("Thursday", value: \.thursdayStr)
            TableColumn("Friday", value: \.fridayStr)
        }
        .onAppear(perform: teacherDailyCount)
    }
}


struct TeacherView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherView()
            .environmentObject(ModelData())
    }
}
