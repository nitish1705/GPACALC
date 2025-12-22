//
//  Subject.swift
//  GPACALC
//
//  Created by Nitish M on 23/12/25.
//

import Foundation
import SwiftData

@Model
class Subject {
    var name: String
    var credit: Double
    var grade: String

    init(
        name: String = "",
        credit: Double = 0.0,
        grade: String = ""
    ) {
        self.name = name
        self.credit = credit
        self.grade = grade
    }
}
