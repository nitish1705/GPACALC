//
//  gradeSettings.swift
//  GPACALC
//
//  Created by Nitish M on 22/12/25.
//

import Foundation
import SwiftData

@Model
class gradeSettings{
    var grade: String
    var points: Double
    
    init(grade: String, points: Double) {
        self.grade = grade
        self.points = points
    }
}
