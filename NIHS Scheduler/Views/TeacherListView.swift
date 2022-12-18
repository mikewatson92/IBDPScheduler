//
//  TeacherListView.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/16.
//

import SwiftUI

enum ActiveSheet: Identifiable, CaseIterable {
    case addTeacher, editTeacher
    
    var id: Int {
        hashValue
    }
}

struct TeacherListView: View {
    @EnvironmentObject var model: ModelData
    @State private var activeSheet: ActiveSheet?
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
    
    var body: some View {
        Table(teacherData, selection: $selectedTeacherID, sortOrder: $sortOrder) {
                TableColumn("Last Name", value: \.lastName)
                TableColumn("First Name", value: \.firstName)
                TableColumn("Homeroom", value: \.homeRoom.rawValue)
        }
        .onDeleteCommand(perform: removeTeacher)
        .navigationTitle("Teachers")
        .sheet(item: $activeSheet) { item in
            switch item {
            case .addTeacher:
                AddTeacher(activeSheet: $activeSheet)
                    .environmentObject(model)
                    .frame(minWidth: 250, minHeight: 250)
            case .editTeacher:
                if selectedTeacherID != nil {
                    EditTeacher(activeSheet: $activeSheet, selectedTeacherID: $selectedTeacherID)
                        .environmentObject(model)
                        .frame(minWidth: 500, minHeight: 500)
                }
            }
        }
        .toolbar {
            ToolbarItemGroup {
                Button {
                    activeSheet = .editTeacher
                } label: {
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.mint)
                }
                Button {
                    activeSheet = .addTeacher
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.green)
                }
            }
            
        }
    }
}


struct TeacherListView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherListView()
    }
}
