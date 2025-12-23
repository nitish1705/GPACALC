//
//  GPACALCApp.swift
//  GPACALC
//
//  Created by Nitish M on 22/12/25.
//

import SwiftUI
import SwiftData

@main
struct GPACALCApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [gradeSettingsModel.self, semesterDetails.self, Subject.self])
    }
}
