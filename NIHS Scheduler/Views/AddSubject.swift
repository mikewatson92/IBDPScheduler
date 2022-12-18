//
//  AddSubject.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/15.
//

import SwiftUI

struct AddSubject: View {
    @EnvironmentObject var model: ModelData
    @Binding var activeSheet: ActiveSubjectSheet?
    @State private var group: Group?
    @State private var grade: Grade?
    @State private var name: String = ""
    @State private var level: String = ""
    @State private var teacher: Teacher?
    var body: some View {
        Form {
            Picker("Group", selection: $group) {
                ForEach(Group.allCases) { group in
                    Text(group.rawValue).tag(group)
                }
            }
            Picker("Grade", selection: $grade) {
                ForEach(Grade.allCases) { grade in
                    Text(grade.rawValue).tag(grade)
                }
            }
            TextField("Subject Name: ", text: $name)
            TextField("Level: ", text: $level)
            Picker("Teacher", selection: $teacher) {
                ForEach(model.teachers) { teacher in
                    Text("\(teacher.lastName), \(teacher.firstName)")
                }
            }
        }
        .padding()
        .navigationTitle("Add Subject")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button() {
                    if group != nil && grade != nil {
                        model.subjects.append(Subject(group: group!, grade: grade!, name: name, level: level, teacher: teacher ?? Teacher(firstName: "?", lastName: "?", homeRoom: .None)))
                        // Save data
                        do {
                            try FileManager().encodeToFile(name: "ModelData.json", content: model)
                        } catch {
                            print("Unable to save data!")
                        }
                        activeSheet = nil
                    }
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.green)
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button() {
                    activeSheet = nil
                } label: {
                    Image(systemName: "x.circle")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

/*
 struct AddSubject_Previews: PreviewProvider {
 static var previews: some View {
 AddSubject()
 }
 }
 */
