//
//  gradeSettingsModel.swift
//  GPACALC
//
//  Created by Nitish M on 23/12/25.
//

import Foundation
import SwiftData

@Model
class gradeSettingsModel{
    var grade: String
    var points: Double
    
    init(grade: String, points: Double) {
        self.grade = grade
        self.points = points
    }
}
