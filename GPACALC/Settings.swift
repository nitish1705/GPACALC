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
                    )

                    Divider()

                    menuButtons(
                        Icon: "party.popper",
                        title: "What's New",
                        about: "Check out the latest features",
                        sizes: 15,
                        colors: .green
                    )
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

#Preview {
    Settings()
}
