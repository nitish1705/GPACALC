//
//  gradeSettings.swift
//  GPACALC
//
//  Created by Nitish M on 23/12/25.
//

import Foundation
import SwiftUI
import SwiftData

struct gradeSettings: View {
    @Bindable var semester: semesterDetails
    @Environment(\.dismiss) private var dismiss
    
    @State private var gradeToAdd: semesterDetails? = nil
    @State private var gradeToEdit: gradeSettingsModel? = nil
    
    func gradeRow(_ grade: gradeSettingsModel) -> some View{
        VStack{
            HStack{
                Text(grade.grade.isEmpty ? "grade" : grade.grade)
                Spacer()
                Text(String(format: "%.1f", grade.points))
                    .frame(width: 50)
            }
            Divider()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        )
    }
    var body: some View {
        NavigationStack{
            ZStack{
                Color.gray.opacity(0.15)
                    .ignoresSafeArea()
                VStack(spacing: 16){
                    VStack{
                        HStack{
                            Text("Grade Name")
                            Spacer()
                            Text("Points")
                        }
                        .foregroundStyle(Color("BGColor"))
                        Divider()
                        List{
                            if semester.grades.isEmpty{
                                VStack(spacing: 6) {
                                    Spacer(minLength: 80)

                                    Text("No Grade Settings added yet")
                                        .foregroundStyle(.secondary)

                                    Text("Tap + to add a Grade Setting")
                                        .foregroundStyle(.secondary)
                                        .font(.caption)

                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                            }
                            else{
                                ForEach(semester.grades) { grade in
                                    gradeRow(grade)
                                        .listRowInsets(EdgeInsets())
                                        .listRowSeparator(.hidden)
                                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                            Button {
                                                gradeToEdit = grade
                                            } label: {
                                                Label("Edit", systemImage: "pencil")
                                            }
                                            .tint(.blue)

                                            Button(role: .destructive) {
                                                if let index = semester.grades.firstIndex(of: grade) {
                                                    semester.grades.remove(at: index)
                                                }
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                }

                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        Spacer()
                    }
                    .padding()
                    .frame(width: 333, height: 600)
                    .background{
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
                    }
                    .padding(.top, -70)
                    Button {
                        gradeToAdd = semester
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add New Grade")
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .frame(width: 260)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
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
                        .shadow(color: Color("BGColor").opacity(0.4), radius: 6, y: 3)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        Button{
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color("BGColor"))
                                .font(.system(size: 20, weight: .semibold))
                        }
                    }
                    ToolbarItem(placement: .principal){
                        Text("Grade Settings")
                            .font(.title.bold())
                    }
                    ToolbarItem(placement: .topBarTrailing){
                        Button{
                            
                        } label: {
                            Image(systemName: "questionmark.circle")
                                .foregroundStyle(Color("BGColor"))
                                .font(.system(size: 20, weight: .semibold))
                        }
                    }
                }
                .sheet(item: $gradeToAdd){semester in
                    addingNewGrade(semester: semester)
                        .presentationDetents([.height(350)])
                }
                .sheet(item: $gradeToEdit){grade in
                    editingGrade(grade: grade)
                        .presentationDetents([.height(350)])
                }
            }
        }
    }
}

struct addingNewGrade: View{
    @Bindable var semester: semesterDetails
    @Environment(\.dismiss) private var dismiss
    @State private var newGrade: String = ""
    @State private var newPoints: Double = 0.0
    
    var body: some View{
        NavigationStack{
            VStack{
                VStack(spacing: 20) {

                    TextField("Enter New Grade", text: $newGrade)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.15))
                        )

                    TextField("Enter new Points", value: $newPoints, format: .number)
                        .keyboardType(.decimalPad)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.15))
                        )
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.horizontal)
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color("BGColor"))
                            .font(.system(size: 20, weight: .semibold))
                    }
                }
                ToolbarItem(placement: .principal){
                    Text("Add New Grade")
                        .font(.title2)
                        .foregroundStyle(Color("BGColor"))
                        .font(.system(size: 20, weight: .semibold))
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        let newgrades = gradeSettingsModel(grade: newGrade, points: newPoints)
                        semester.grades.append(newgrades)
                        dismiss()
                    } label: {
                        Text("Done")
                            .foregroundStyle(Color("BGColor"))
                            .font(.system(size: 20, weight: .semibold))
                    }
                }
            }
        }
    }
}
struct editingGrade: View {
    @Bindable var grade: gradeSettingsModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack{
            VStack {
                VStack(spacing: 20) {
                    TextField("Enter correct Grade", text: $grade.grade)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.15))
                        )

                    TextField("Enter correct Points", value: $grade.points, format: .number)
                        .keyboardType(.decimalPad)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.15))
                        )

                    Spacer()
                }
                .padding(.top, 30)
                .padding(.horizontal)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color("BGColor"))
                            .font(.system(size: 20, weight: .semibold))
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text("Edit Grade")
                        .foregroundStyle(Color("BGColor"))
                        .font(.system(size: 20, weight: .semibold))
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundStyle(Color("BGColor"))
                    .font(.system(size: 20, weight: .semibold))
                }
            }
        }
    }
}
