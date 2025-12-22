import SwiftData

@Model
class semesterDetails {
    var index: Int

    @Relationship(deleteRule: .cascade)
    var subjects: [Subject]

    init(
        index: Int,
        subjects: [Subject] = []
    ) {
        self.index = index
        self.subjects = subjects
    }
}
