//
//  EditTeacher.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import SwiftUI

struct EditTeacher: View {
    @EnvironmentObject var model: ModelData
    @Binding var activeSheet: ActiveSheet?
    @Binding var selectedTeacherID: UUID?
    @State var newGroup: Group = .none
    
    var body: some View {
        ScrollView{
            Form {
                TextField("Last Name: ", text: $model.teachers.first(where: { $0.id == selectedTeacherID! })!.lastName)
                TextField("First Name: ", text: $model.teachers.first(where: { $0.id == selectedTeacherID! })!.firstName)
                Picker("HomeRoom", selection: $model.teachers.first(where: { $0.id == selectedTeacherID! })!.homeRoom) {
                    Text("None").tag(Grade.None)
                    Text("Pre-IB").tag(Grade.PreIB)
                    Text("DP 1").tag(Grade.DP1)
                    Text("DP 2").tag(Grade.DP2)
                }
                
                ForEach(model.subjects.filter({ $0.teacher.id == selectedTeacherID }), id: \.self) { aSubject in
                    Divider()
                    
                    Button() {
                        model.subjects.removeAll(where: { $0.id == aSubject.id })
                        
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                    }
                    
                    Picker("Group", selection: $model.subjects.filter({ $0.id == aSubject.id }).first!.group) {
                        ForEach(Group.allCases) { group in
                            Text(group.rawValue).tag(group)
                        }
                    }
                    
                    Picker("Grade", selection: $model.subjects.filter({ $0.id == aSubject.id }).first!.grade) {
                        ForEach(Grade.allCases) { grade in
                            Text(grade.rawValue).tag(grade)
                        }
                    }
                    
                    TextField("Name", text: $model.subjects.filter({ $0.id == aSubject.id }).first!.name)
                    TextField("Level", text: $model.subjects.filter({ $0.id == aSubject.id }).first!.level)
                }
                
                Button() {
                    model.subjects.append(Subject(id: UUID().uuidString, group: .none, grade: .None, name: "", level: "", teacher: model.teachers.first(where: { $0.id == selectedTeacherID })!, roster: nil))
                } label: {
                    Label("Add New Subject", systemImage: "note.text.badge.plus")
                        .frame(alignment: .center)
                }
            }
        }
        .padding()
        .navigationTitle("Edit Teacher")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button() {
                    // Update each subject's teacher name, in the event of renaming a teacher.
                    for subject in model.subjects.filter({ $0.teacher.id == selectedTeacherID! }) {
                        let subjectIndex = model.subjects.firstIndex(of: subject)
                        model.subjects[subjectIndex!].teacher.lastName = model.teachers.first(where: { $0.id == selectedTeacherID! })!.lastName
                        model.subjects[subjectIndex!].teacher.firstName = model.teachers.first(where: { $0.id == selectedTeacherID! })!.firstName
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
 struct EditTeacher_Previews: PreviewProvider {
 static var previews: some View {
 EditTeacher(activeSheet: .constant(.editTeacher), index: 0)
 .environmentObject(ModelData())
 }
 }
 */
