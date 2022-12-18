//
//  AddTeacher.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import SwiftUI

struct AddTeacher: View {
    @EnvironmentObject var model: ModelData
    @Binding var activeSheet: ActiveSheet?
    @State var lastName: String = ""
    @State var firstName: String = ""
    @State var homeRoom: Grade = .None
    @State var numberOfSubjects: Int = 1
    
    var body: some View {
        Form {
            TextField("Last Name", text: $lastName)
            TextField("First Name", text: $firstName)
            Picker("Homeroom: ", selection: $homeRoom) {
                Text("None").tag(Grade.None)
                Text("Pre-IB").tag(Grade.PreIB)
                Text("DP 1").tag(Grade.DP1)
                Text("DP 2").tag(Grade.DP2)
            }
        }
        .padding()
        .navigationTitle("Add Teacher")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button() {
                    let newTeacher = Teacher(firstName: firstName, lastName: lastName, homeRoom: homeRoom)
                    
                    model.teachers.append(newTeacher)
                    
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

struct AddTeacher_Previews: PreviewProvider {
    static var previews: some View {
        AddTeacher(activeSheet: .constant(.addTeacher))
    }
}
