//
//  EditSubject.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/15.
//

import SwiftUI

struct EditSubject: View {
    @EnvironmentObject var model: ModelData
    @Binding var activeSheet: ActiveSubjectSheet?
    @Binding var selectedSubjectID: String? //A UUID String
    
    var body: some View {
        ScrollView {
            Form {
                TextField("Subject: ", text: $model.subjects.first(where: { $0.id == selectedSubjectID })!.name)
                TextField("Level: ", text: $model.subjects.first(where: { $0.id == selectedSubjectID })!.level)
                
                Picker("Category: ", selection: $model.subjects.first(where: { $0.id == selectedSubjectID})!.group) {
                    ForEach(Group.allCases) { group in
                        Text(group.rawValue).tag(group)
                    }
                }
                Picker("Grade: ", selection: $model.subjects.first(where: { $0.id == selectedSubjectID })!.grade) {
                    ForEach(Grade.allCases) { grade in
                        Text(grade.rawValue).tag(grade)
                    }
                }
                Picker("Teacher: ", selection: $model.subjects.first(where: { $0.id == selectedSubjectID })!.teacher) {
                    ForEach(model.teachers) { teacher in
                        Text("\(teacher.lastName), \(teacher.firstName)").tag(teacher)
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Edit Subject")
        .toolbar {
            ToolbarItem {
                Button() {
                    // Save data
                    do {
                        try FileManager().encodeToFile(name: "ModelData.json", content: model)
                    } catch {
                        print("Unable to save data!")
                    }
                    activeSheet = nil
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.green)
                }
            }
        }
    }
}

/*
 struct EditSubject_Previews: PreviewProvider {
 static var previews: some View {
 EditSubject()
 }
 }
 */
