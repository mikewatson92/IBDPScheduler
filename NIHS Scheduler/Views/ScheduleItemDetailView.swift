//
//  ScheduleItemDetailView.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/10.
//

import SwiftUI

struct ScheduleItemDetailView: View {
    @EnvironmentObject var model: ModelData
    @Binding var activeSheet: CalendarActiveSheet?
    @Binding var modelsIndex: Int?
    @Binding var itemIndex: Int?

    var body: some View {
        List {
            Text("Lesson Info")
                .font(.title)
            
            Section("Class Info") {
                HStack {
                    Text("Teacher: ")
                    Text("\(model.calendarModels[modelsIndex!].items[itemIndex!].subject!.teacher.lastName)")
                }
                HStack {
                    Text("Grade: ")
                    Text("\(model.calendarModels[modelsIndex!].items[itemIndex!].subject!.grade.rawValue)")
                }
                HStack {
                    Text("Group: ")
                    Text("\(model.calendarModels[modelsIndex!].items[itemIndex!].subject!.group.rawValue)")
                }
                HStack {
                    Text("Subject: ")
                    Text("\(model.calendarModels[modelsIndex!].items[itemIndex!].subject!.name)")
                }
                HStack {
                    Text("Level: ")
                    Text("\(model.calendarModels[modelsIndex!].items[itemIndex!].subject!.level)")
                }
            }
            Section("Schedule Info") {
                
                HStack {
                    Text("Day: ")
                    Text("\(model.calendarModels[modelsIndex!].day?.rawValue ?? "nil")")
                }
                HStack {
                    Text("Period: ")
                    Text("\(model.calendarModels[modelsIndex!].period?.rawValue ?? "nil")")
                }
            }
        }
    }
}

/*
 struct ScheduleItemDetailView_Previews: PreviewProvider {
 static var previews: some View {
 ScheduleItemDetailView()
 .environmentObject(ModelData())
 }
 }
 */
