//
//  SubjectView.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import SwiftUI

enum ActiveSubjectSheet: Identifiable, CaseIterable {
    case addSubject, editSubject
    
    var id: Int {
        hashValue
    }
}

struct SubjectView: View {
    @EnvironmentObject var model: ModelData
    @State private var selectedSubjectID: Subject.ID?
    @State private var sortOrder = [KeyPathComparator(\Subject.grade.rawValue)]
    @State private var activeSheet: ActiveSubjectSheet?
    var subjectIndex: Int? {
        model.subjects.firstIndex(where: { $0.id == selectedSubjectID })
    }
    var subjectData: [Subject] {
        return model.subjects.sorted(using: sortOrder)
    }
    
    func removeSubject() {
        model.subjects.removeAll(where: { $0.id == selectedSubjectID! })
        for var cvm in model.calendarModels {
            cvm.items.removeAll(where: { $0.id == selectedSubjectID! })
        }
        // Save data
        do {
            try FileManager().encodeToFile(name: "ModelData.json", content: model)
        } catch {
            print("Unable to save data!")
        }
    }
    
    var body: some View {
        Table(subjectData, selection: $selectedSubjectID, sortOrder: $sortOrder) {
            TableColumn("Grade", value: \.grade.rawValue)
            TableColumn("Subject", value: \.name)
            TableColumn("Level", value: \.level)
            TableColumn("Teacher", value: \.teacher.lastName)
            TableColumn("Number of Lessons", value: \.numberOfLessonsStr)
        }
        .onDeleteCommand(perform: removeSubject)
        .navigationTitle("Subjects")
        .toolbar {
            ToolbarItemGroup {
                Button {
                    activeSheet = .editSubject
                } label: {
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.mint)
                }
                Button {
                    activeSheet = .addSubject
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.green)
                }
            }
        }
        .sheet(item: $activeSheet) { item in
            switch item {
            case .addSubject:
                AddSubject(activeSheet: $activeSheet)
                    .environmentObject(model)
                    .frame(minWidth: 250, minHeight: 250)
            case .editSubject:
                if selectedSubjectID != nil {
                    EditSubject(activeSheet: $activeSheet, selectedSubjectID: $selectedSubjectID)
                        .environmentObject(model)
                        .frame(minWidth: 500, minHeight: 500)
                }
            }
        }
    }
}

struct SubjectView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectView()
            .environmentObject(ModelData())
    }
}
