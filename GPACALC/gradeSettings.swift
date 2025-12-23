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
                            Spacer()
                            Text("Actions")
                        }
                        .foregroundStyle(Color("BGColor"))
                        Divider()
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
                    Button(){
                        
                    } label: {
                        Text("Hey")
                    }
                }
                .navigationBarBackButtonHidden(true)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        Button{
                            
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
            }
        }
    }
}

#Preview {
    gradeSettings()
}
