//
//  HelpGuideView.swift
//  GPACALC
//
//  Created by Nitish M on 27/12/25.
//

import Foundation
import SwiftUI

struct HelpGuideView: View {
    @Environment(\.dismiss) private var dismiss

    let guideImages = [
        "Image1", "Image2", "Image3", "Image4", "Image5",
        "Image6", "Image7", "Image8", "Image9", "Image10", "Image11"
    ]

    var body: some View {
        VStack {
            TabView {
                ForEach(guideImages, id: \.self) { imageName in
                    GuidePage(image: imageName)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))

            Button{
                dismiss()
            } label: {
                Text("Got it!")
                    .foregroundColor(.white)
                    .frame(maxWidth: 200)
                    .frame(maxHeight: 50)
                    .background(Color("BGColor"))
                    .cornerRadius(12)
            }
            .padding()
            .font(.headline)
        }
        .background(Color(.systemBackground))
    }
}

struct GuidePage: View {
    let image: String
    var body: some View {
        VStack(spacing: 20) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 620)
                .foregroundColor(.accentColor)
        }
        .padding()
    }
}

#Preview{
    HelpGuideView()
}
