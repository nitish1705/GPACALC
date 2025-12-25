//
//  Settings.swift
//  GPACALC
//
//  Created by Nitish M on 25/12/25.
//

import SwiftUI
import SwiftData

struct Settings: View {

    @Environment(\.dismiss) private var dismiss

    enum Appearance {
        case light, dark, auto
    }

    @State private var selectedAppearance: Appearance = .light

    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.15).ignoresSafeArea()

                VStack {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image(systemName: "paintpalette.fill")
                                .foregroundColor(Color("BGColor"))

                            Text("Appearance")
                                .font(.headline)

                            Spacer()
                        }
                        HStack(spacing: 16) {
                            Spacer()
                            appearanceButton(
                                icon: "sun.max.fill",
                                title: "Light",
                                type: .light
                            )
                            appearanceButton(
                                icon: "moon.fill",
                                title: "Dark",
                                type: .dark
                            )
                            appearanceButton(
                                icon: "iphone",
                                title: "Auto",
                                type: .auto
                            )
                            Spacer()
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.08), radius: 8)
                    )
                    .padding(.horizontal)
                    VStack(spacing: 20){
                        menuButtons(Icon: "star.fill", title: "Grade Settings", about: "Configure your grading System", sizes: 14)
                        Divider()
                        menuButtons(Icon: "questionmark.circle", title: "Help & Tutorial", about: "Learn how to use the app", sizes: 18)
                        Divider()
                        menuButtons(Icon: "questionmark.circle", title: "Help & Tutorial", about: "Learn how to use the app", sizes: 18)
                    }
                    .padding()
                    .frame(maxWidth: 360)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                    )
                    .padding(.top, 30)
                    Spacer()
                }
                
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Settings")
                            .font(.system(size: 30, weight: .semibold))
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "house.fill")
                                .foregroundStyle(Color("BGColor"))
                                .font(.system(size: 20, weight: .semibold))
                        }
                    }
                }
            }
        }
    }
    @ViewBuilder
    private func appearanceButton(
        icon: String,
        title: String,
        type: Appearance
    ) -> some View {
        Button {
            withAnimation(.easeInOut) {
                selectedAppearance = type
            }
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 22))

                Text(title)
                    .font(.caption)
            }
            .frame(width: 90, height: 150)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        selectedAppearance == type
                        ? Color("BGColor").opacity(0.55)
                        : Color(.systemGray6)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        selectedAppearance == type
                        ? Color("BGColor")
                        : Color.clear,
                        lineWidth: 2
                    )
            )
        }
        .buttonStyle(.plain)
    }
    @ViewBuilder
    private func menuButtons(
        Icon: String,
        title: String,
        about: String,
        sizes: CGFloat
    ) -> some View {
        Button{
            
        } label: {
            HStack{
                Image(systemName: Icon)
                    .foregroundStyle(Color.blue)
                    .font(.system(size: 35))
                    .padding(.trailing, 10)
                
                VStack{
                    Text(title)
                        .foregroundStyle(Color.primary)
                    
                    Text(about)
                        .foregroundStyle(Color.secondary)
                        .font(.system(size: sizes))
                }
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.primary)
                    .font(.system(size: 22))
                    .padding(.trailing, 10)
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.secondary.opacity(0.15))
            )
        }
    }
}
#Preview{
    Settings()
}
