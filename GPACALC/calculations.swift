//
//  calculations.swift
//  GPACALC
//
//  Created by Nitish M on 24/12/25.
//

import Foundation

func calculateGPA(
    subjects: [Subject],
    grades: [gradeSettingsModel]
) -> Double {

    var totalPoints = 0.0
    var totalCredits = 0.0

    for subject in subjects {
        guard
            let gradePoint = grades.first(where: { $0.grade == subject.grade })?.points
        else { continue }

        totalPoints += gradePoint * subject.credit
        totalCredits += subject.credit
    }

    guard totalCredits > 0 else { return 0.0 }
    return totalPoints / totalCredits
}

func calculateScoredCredits(
    subjects: [Subject],
    grades: [gradeSettingsModel]
) -> Double {

    let validGrades = Set(grades.map { $0.grade })

    return subjects
        .filter { validGrades.contains($0.grade) }
        .reduce(0) { $0 + $1.credit }
}

func calculateCGPA(semesters: [semesterDetails]) -> Double {

    var totalPoints = 0.0
    var totalCredits = 0.0

    for semester in semesters {

        let grades = semester.grades

        for subject in semester.subjects {

            guard
                let gradePoint = grades.first(where: {
                    $0.grade == subject.grade
                })?.points
            else { continue }

            totalPoints += gradePoint * subject.credit
            totalCredits += subject.credit
        }
    }

    guard totalCredits > 0 else { return 0.0 }
    return totalPoints / totalCredits
}

func calculateTotalCredits2(
    semesters: [semesterDetails]
) -> Double {

    semesters
        .flatMap { $0.subjects }
        .reduce(0) { $0 + $1.credit }
}

func calculateScoredCredits2(
    semesters: [semesterDetails]
) -> Double {

    var scoredCredits = 0.0

    for semester in semesters {

        let validGrades = Set(semester.grades.map { $0.grade })

        for subject in semester.subjects {
            if validGrades.contains(subject.grade) {
                scoredCredits += subject.credit
            }
        }
    }

    return scoredCredits
}
