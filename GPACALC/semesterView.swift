//
//  semesterView.swift
//  GPACALC
//
//  Created by Nitish M on 23/12/25.
//

import Foundation
import SwiftUI
import SwiftData

import SwiftUI
import SwiftData

struct semesterView: View {
    @Bindable var semester: semesterDetails
    @Environment(\.dismiss) private var dismiss

    @State private var subjectToAdd: Subject? = nil
    @State private var subjectToEdit: Subject? = nil
    @State private var gradeToAdd:semesterDetails? = nil
    @ViewBuilder
    func subjectRow(_ subject: Subject) -> some View {
        VStack{
            HStack {
                Text(subject.name.isEmpty ? "Subject" : subject.name)

                Spacer()

                Text(String(format: "%.1f", subject.credit))
                    .frame(width: 50)
                Spacer()

                Text(subject.grade.isEmpty ? "-" : subject.grade)
                    .frame(width: 40)
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
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.15)
                    .ignoresSafeArea()

                VStack(spacing: 16) {

                    Text("GPA: 0.00")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(width: 350, height: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                        )
                        .shadow(color: .black.opacity(0.1), radius: 4, y: 2)

                    VStack(spacing: 0) {
                        HStack {
                            Text("Subject Name")
                            Spacer()
                            Text("Credit")
                            Spacer()
                            Text("Grade")
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding()
                        .background(Color.white)

                        Divider()

                        List {
                            if semester.subjects.isEmpty {
                                VStack(spacing: 6) {
                                    Spacer(minLength: 80)

                                    Text("No subjects added yet")
                                        .foregroundStyle(.secondary)

                                    Text("Tap + to add subjects")
                                        .foregroundStyle(.secondary)
                                        .font(.caption)

                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                            } else {
                                ForEach(semester.subjects) { subject in
                                    subjectRow(subject)
                                        .listRowInsets(EdgeInsets())
                                        .listRowSeparator(.hidden)
                                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {

                                            Button {
                                                subjectToEdit = subject
                                            } label: {
                                                Label("Edit", systemImage: "pencil")
                                            }
                                            .tint(.blue)

                                            Button(role: .destructive) {
                                                if let index = semester.subjects.firstIndex(of: subject) {
                                                    semester.subjects.remove(at: index)
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
                    }
                    .frame(width: 350, height: 530)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
                    )

                    Button {
                        subjectToAdd = Subject()
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Subject")
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .frame(width: 260)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("BGColor"))
                        )
                        .shadow(color: Color("BGColor").opacity(0.4), radius: 6, y: 3)
                    }

                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Semester \(semester.index)")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }

                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "house.fill")
                                .foregroundStyle(Color("BGColor"))
                                .font(.system(size: 20, weight: .semibold))
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing){
                        Button{
                            gradeToAdd = semester
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundStyle(Color("BGColor"))
                                .font(.system(size: 20, weight: .semibold))
                        }
                    }
                }

                .sheet(item: $subjectToAdd) { _ in
                    addSubjectSheet(semester: semester)
                        .presentationDetents([.height(350)])
                }
                .sheet(item: $subjectToEdit){subject in
                    editSubjectSheet(subject: subject)
                        .presentationDetents([.height(350)])
                }
                .navigationDestination(item: $gradeToAdd){semester in
                    gradeSettings(semester: semester)
                }
            }
        }
    }
}

struct addSubjectSheet: View {
    @Bindable var semester: semesterDetails
    @Environment(\.dismiss) private var dismiss

    @State private var newSubject = ""
    @State private var newCredit: Double = 0.0
    @State private var newGrade = ""

    var body: some View {
        NavigationStack {
                VStack(spacing: 20) {

                    TextField("Enter Subject Name", text: $newSubject)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.15))
                        )

                    TextField("Credit", value: $newCredit, format: .number)
                        .keyboardType(.decimalPad)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.15))
                        )

                    TextField("Enter Grade", text: $newGrade)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.15))
                        )

                    Spacer()
                }
                .padding(.top, 30)
                .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(Color("BGColor"))
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let subject = Subject(
                            name: newSubject,
                            credit: newCredit,
                            grade: newGrade
                        )
                        semester.subjects.append(subject)
                        dismiss()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color("BGColor"))
                            .font(.system(size: 20, weight: .semibold))
                    }
                }
            }
        }
    }
}
struct editSubjectSheet: View{
    @Bindable var subject: Subject
    @Environment(\.dismiss) private var dismiss
    var body: some View{
        NavigationStack{
            VStack(spacing: 20) {
                TextField("Enter new Subject Name", text: $subject.name)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.15))
                    )

                TextField("Credit", value: $subject.credit, format: .number)
                    .keyboardType(.decimalPad)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.15))
                    )

                TextField("Enter Grade", text: $subject.grade)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.15))
                    )
                Spacer()
            }
            .padding(.top, 30)
            .padding(.horizontal)
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
                    Text("Edit Subject")
                        .foregroundStyle(Color("BGColor"))
                        .font(.system(size: 20, weight: .semibold))
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button{
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
