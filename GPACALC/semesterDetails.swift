import SwiftData

@Model
class semesterDetails {
    var index: Int

    @Relationship(deleteRule: .cascade)
    var subjects: [Subject] = []

    init(index: Int) {
        self.index = index
    }
}

