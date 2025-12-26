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
    
    @AppStorage("appTheme") private var appTheme: String = "System"
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(
                    appTheme == "light" ? .light : appTheme == "dark" ? .dark : nil
                )
        }
        .modelContainer(for: [gradeSettingsModel.self, semesterDetails.self, Subject.self])
    }
    private func resolveTheme() -> ColorScheme? {
        switch appTheme {
        case "light":
            return .light
        case "dark":
            return .dark
        default:
            return nil
        }
    }
}
