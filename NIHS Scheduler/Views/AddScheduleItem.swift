//
//  AddScheduleItem.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import SwiftUI

struct AddScheduleItem: View {
    @EnvironmentObject var model: ModelData
    @Binding var activeSheet: CalendarActiveSheet?
    @Binding var modelsIndex: Int?
    @Binding var itemIndex: Int?
    @State var selectedSubject: Subject?
    @State var numberOfLessons: Int = 1
    
    var body: some View {
        Form {
            Picker("Class: ", selection: $selectedSubject) {
                Text("").tag(nil as Subject?)
                ForEach(model.subjects.sorted(by: { $0.label < $1.label }), id: \.self) { item in
                    Text("\(item.label)").tag(item as Subject?)
                }
            }
            .padding()
            
            TextField("Number of lessons:", value: $numberOfLessons, formatter: NumberFormatter())
                .padding()
                .frame(width: 250)
        }
        .navigationTitle("Add Lessons")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button() {
                    if numberOfLessons > 0 && selectedSubject != nil {
                        for _ in 1...numberOfLessons {
                            let newScheduleItem = ScheduleItem(id: UUID().uuidString, name: selectedSubject?.label, subject: selectedSubject, teacher: selectedSubject?.teacher)
                            model.scheduleItems.append(newScheduleItem)
                            model.calendarModels.append(CalendarViewModel(day: nil, period: nil, items: [newScheduleItem]))
                            let subjectIndex = model.subjects.firstIndex(of: newScheduleItem.subject!)
                            model.subjects[subjectIndex!].numberOfLessons += 1
                        }
                    }
                    
                    // Save data
                    do {
                        try FileManager().encodeToFile(name: "ModelData.json", content: model)
                    } catch {
                        print("Unable to save data!")
                    }
                    
                    activeSheet = nil
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color.green)
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button() {
                    activeSheet = nil
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(Color.red)
                }
            }
        }
    }
}

/*
 struct AddScheduleItem_Previews: PreviewProvider {
 static var previews: some View {
 AddScheduleItem(activeSheet: .constant(.addScheduleItem), models: .constant([]))
 .environmentObject(ModelData())
 }
 }
 */
