//
//  NIHS_SchedulerApp.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import SwiftUI

@main
struct NIHS_SchedulerApp: App {
    @StateObject var model = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
