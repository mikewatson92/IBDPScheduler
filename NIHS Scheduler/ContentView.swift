//
//  ContentView.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ModelData
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func clearFiles() {
        let fileNameToDelete = "ModelData.json"
        var filePath = ""

        // Fine documents directory on device
         let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)

        if dirs.count > 0 {
            let dir = dirs[0] //documents directory
            filePath = dir.appendingFormat("/" + fileNameToDelete)
            print("Local path = \(filePath)")
         
        } else {
            print("Could not find local directory to store file")
            return
        }


        do {
             let fileManager = FileManager.default
            
            // Check if file exists
            if fileManager.fileExists(atPath: filePath) {
                // Delete file
                try fileManager.removeItem(atPath: filePath)
            } else {
                print("File does not exist")
            }
         
        }
        catch let error as NSError {
            print("An error took place: \(error)")
        }
    }

    var body: some View {
        NavigationSplitView{
            List{
                Section("Calendar") {
                    NavigationLink("Calendar") {
                        CalendarView()
                            .environmentObject(model)
                    }
                }
                Section("Data") {
                    NavigationLink("Teachers", destination: TeacherListView()
                        .environmentObject(model))
                    NavigationLink("Work Load", destination: TeacherView()
                        .environmentObject(model))
                    NavigationLink("Subjects", destination: SubjectView()
                        .environmentObject(model))
                }
            }
            .onAppear {
                //clearFiles()
                if let loadedModel: ModelData = try? FileManager().decodeFromFile(name: "ModelData.json") {
                    model.teachers = loadedModel.teachers
                    model.students = loadedModel.students
                    model.subjects = loadedModel.subjects
                    model.scheduleItems = loadedModel.scheduleItems
                    model.calendarModels = loadedModel.calendarModels
                }
            }
        } detail: {
            NavigationStack {
                CalendarView()
                    .environmentObject(model)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
