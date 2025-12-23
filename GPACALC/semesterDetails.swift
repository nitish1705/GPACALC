import SwiftData

@Model
class semesterDetails {
    var index: Int

    @Relationship(deleteRule: .cascade)
    var subjects: [Subject] = []
    
    @Relationship(deleteRule: .cascade)
    var grades: [gradeSettingsModel] = []

    init(index: Int) {
        self.index = index
    }
}

