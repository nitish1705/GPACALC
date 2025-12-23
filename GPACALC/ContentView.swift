import SwiftUI
import SwiftData

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext

    @Query(sort: \semesterDetails.index)
    private var semesters: [semesterDetails]
    
    @State private var currSemester: semesterDetails? = nil
    @State private var semesterCount: Int = 0

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 14) {

                        Text("0.00")
                            .font(.system(size: 44, weight: .bold))

                        Text("Cumulative CGPA")
                            .font(.headline)
                            .opacity(0.9)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Total Credits: 0.0")
                            Text("Credits Scored: 0.0")
                        }
                        .font(.subheadline)
                        .opacity(0.8)
                    }
                    .foregroundStyle(.white)

                    Spacer()

                    Button {
                        semesterCount += 1
                        modelContext.insert(
                            semesterDetails(index: semesterCount)
                        )
                    } label: {
                        VStack(spacing: 6) {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30, weight: .semibold))
                            Text("Add")
                            Text("Semester")
                        }
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.2))
                        )
                    }
                }
                .padding(30)
                .frame(width: 370)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color("BGColor"),
                                    Color("BGColor").opacity(0.8)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(
                            color: .black.opacity(0.25),
                            radius: 12,
                            x: 0,
                            y: 6
                        )
                )
                Text("Your Semesters")
                    .foregroundStyle(.secondary)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 12)

                List {
                    ForEach(semesters) { semester in
                        semesterCard(semester: semester)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .padding(.vertical, 10)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    modelContext.delete(semester)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .onTapGesture {
                                currSemester = semester
                            }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .onAppear {
                semesterCount = semesters.count
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("GPA & CGPA Calculator")
                        .font(.title2)
                        .fontWeight(.semibold)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(Color("BGColor"))
                            .font(.system(size: 20, weight: .semibold))
                    }
                }
            }
            .fullScreenCover(item: $currSemester) { semester in
                semesterView(semester: semester)
            }
        }
    }
}


@ViewBuilder
func semesterCard(semester: semesterDetails) -> some View {
    HStack {

        VStack(alignment: .leading, spacing: 10) {
            Text("Semester \(semester.index)")
                .font(.title3)
                .fontWeight(.semibold)

            Text("Total Credits: 0.0")
                .foregroundStyle(.secondary)

            Text("Scored Credits: 0.0")
                .foregroundStyle(.secondary)
        }
        Spacer()
        VStack(alignment: .trailing, spacing: 6) {
            Text("GPA")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text("0.00")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(Color("BGColor"))
        }
    }
    .padding(20)
    .frame(maxWidth: .infinity)
    .background(
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(.systemBackground))
            .shadow(color: .black.opacity(0.1), radius: 6, y: 3)
    )
}

#Preview {
    ContentView()
}
