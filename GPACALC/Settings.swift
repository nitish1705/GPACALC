import SwiftUI
import SwiftData

struct Settings: View {

    @Environment(\.dismiss) private var dismiss
    @AppStorage("appTheme") private var appTheme = "system"

    enum Appearance {
        case light, dark, auto
    }

    @State private var selectedAppearance: Appearance = .light
    @State private var showInfo = false
    @State private var showGuide = false
    @State private var showNew = false

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(systemName: "paintpalette.fill")
                            .foregroundColor(.primary)

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
                        .fill(Color(.secondarySystemBackground))
                )
                .padding(.horizontal)

                VStack(spacing: 20) {
                    menuButtons(
                        Icon: "star.fill",
                        title: "Grade Settings",
                        about: "Configure your grading System",
                        sizes: 14,
                        colors: Color("BGColor")
                    ) {
                        showInfo = true
                    }

                    Divider()

                    menuButtons(
                        Icon: "questionmark.circle",
                        title: "Help & Tutorial",
                        about: "Learn how to use the app",
                        sizes: 18,
                        colors: .blue
                    ){
                        showGuide = true
                    }

                    Divider()

                    menuButtons(
                        Icon: "party.popper",
                        title: "What's New",
                        about: "Check out the latest features",
                        sizes: 15,
                        colors: .green
                    ){
                        showNew = true
                    }
                }
                .padding()
                .frame(maxWidth: 360)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))
                )
                .padding(.top, 30)

                Spacer()
            }
            .alert("ⓘ Note", isPresented: $showInfo) {
                Button("Close", role: .cancel) {}
            } message: {
                Text("You can change the grading system inside any semester.")
            }
            .sheet(isPresented: $showGuide){
                HelpGuideView()
            }
            .sheet(isPresented: $showNew){
                newSheet()
                    .presentationDetents([.medium, .large])
            }
            .navigationBarBackButtonHidden(true)
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
                            .foregroundStyle(.primary)
                    }
                }
            }
            .onAppear {
                syncAppearance()
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

            switch type {
            case .light:
                appTheme = "light"
            case .dark:
                appTheme = "dark"
            case .auto:
                appTheme = "system"
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
                        ? Color("BGColor").opacity(0.25)
                        : Color(.secondarySystemBackground)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        selectedAppearance == type ? Color("BGColor") : .clear,
                        lineWidth: 2
                    )
            )
        }
        .buttonStyle(.plain)
    }

    private func syncAppearance() {
        switch appTheme {
        case "light":
            selectedAppearance = .light
        case "dark":
            selectedAppearance = .dark
        default:
            selectedAppearance = .auto
        }
    }

    
    @ViewBuilder
    private func menuButtons(
        Icon: String,
        title: String,
        about: String,
        sizes: CGFloat,
        colors: Color,
        action: (() -> Void)? = nil
    ) -> some View {
        Button {
            action?()
        } label: {
            HStack {
                Image(systemName: Icon)
                    .foregroundStyle(colors)
                    .font(.system(size: 35))
                    .padding(.trailing, 10)

                VStack(alignment: .leading) {
                    Text(title)
                        .foregroundStyle(Color(.label))
                    Text(about)
                        .foregroundStyle(Color(.label).opacity(0.6))
                        .font(.system(size: sizes))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemBackground))
            )
        }
    }
}

struct newSheet: View {
    
    @Environment(\.dismiss) private var dismiss

    func bullet(_ text: String) -> some View {
        HStack(alignment: .top) {
            Text("•")
            Text(text)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        bullet("The App is now available on the App Store!")
                        bullet("Major UI improvements across the app.")
                        bullet("Each semester now has its own grading system.")
                        bullet("Dark mode support added.")
                        bullet("Improved performance and UI consistency.")
                    }
                    .padding()

                    Button {
                        dismiss()
                    } label: {
                        Text("Got it!")
                            .foregroundColor(.white)
                            .frame(maxWidth: 200)
                            .frame(height: 50)
                            .background(Color("BGColor"))
                            .cornerRadius(12)
                    }
                    .padding(.bottom, 20)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("What's New")
                        .font(.title)
                        .bold()
                }
            }
        }
    }
}

#Preview {
    newSheet()
}
