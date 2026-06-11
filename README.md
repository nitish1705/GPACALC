# GPACALC

A GPA and CGPA calculator for iOS that allows students to track grades across multiple semesters with customizable grading scales.

## Features

- Calculate semester GPA and cumulative CGPA automatically
- Add multiple semesters and subjects with credits and grades
- Define custom grading systems per semester (e.g., A=4.0, B=3.5)
- Track total credits and scored credits across all semesters
- Light, dark, and automatic theme support
- Edit or delete semesters and subjects
- Help guide with step-by-step instructions
- Persistent data storage with SwiftData

## Tech Stack

- Swift (iOS)
- SwiftUI for user interface
- SwiftData for local data persistence
- Xcode project structure

## Project Structure

```
GPACALC/
├── GPACALCApp.swift              # App entry point with SwiftData container setup
├── ContentView.swift             # Home screen with semester list and CGPA display
├── semesterView.swift            # Semester details and subject management
├── semesterDetails.swift         # Semester data model with subjects and grades
├── Subject.swift                 # Subject data model
├── gradeSettings.swift           # Grade scale configuration UI
├── gradeSettingsModel.swift      # Grade point data model
├── calculations.swift            # GPA and CGPA calculation functions
├── Settings.swift                # App settings and help
├── HelpGuideView.swift           # Tutorial pages
├── Assets.xcassets/              # App icons and images
└── GPACALC.xcodeproj/            # Xcode project configuration

GPACALCUITests/
└── GPACALCUITests.swift          # UI tests for navigation
```

## Getting Started

### Prerequisites

- Xcode 15 or later
- iOS 17 or later
- macOS with development tools

### Installation

1. Clone the repository:
```bash
git clone https://github.com/nitish1705/GPACALC.git
cd GPACALC
```

2. Open the project in Xcode:
```bash
open GPACALC.xcodeproj
```

### Running the Project

1. Select a simulator or device in Xcode
2. Press `Cmd + R` or click the play button to build and run
3. The app launches with the home screen

## Configuration

App appearance is stored in `AppStorage` with the key `"appTheme"`. Valid values are:
- `"light"` — Force light mode
- `"dark"` — Force dark mode
- `"system"` — Follow system appearance (default)

## Dependencies

Important dependencies managed through SwiftData and built-in frameworks:

- **SwiftUI**: Declarative UI framework
- **SwiftData**: Local data persistence (models: `Subject`, `semesterDetails`, `gradeSettingsModel`)
- **Foundation**: Core utilities

## Notes

### Data Model

The app uses three main SwiftData models:
- `semesterDetails`: Contains semester index, subjects, and grade settings
- `Subject`: Stores subject name, credit hours, and earned grade
- `gradeSettingsModel`: Maps grade letters to point values (e.g., "A" → 4.0)

### GPA Calculation

Semester GPA is calculated as: (sum of grade points × credits) / total credits

Cumulative CGPA aggregates all semesters using the same formula.

Scored credits only count subjects with valid grades defined in the grading system.

### Grade System

Each semester can have its own grading scale. This allows flexibility for institutions with different systems. Grades are matched when calculating GPA—if a subject has a grade not in the scale, it is ignored.

### UI Tests

The `GPACALCUITests` suite verifies navigation between home and settings screens using accessibility identifiers.

## License

This project is licensed under the MIT License — see the LICENSE file for details.
