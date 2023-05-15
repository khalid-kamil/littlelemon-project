//
//  HomeView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 14/05/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        VStack(spacing: 16) {
            Text("[Little Lemon Home Screen]")
                .font(.system(size: 20,
                              weight: .heavy))
            Button {
                withAnimation {
                    session.signOut()
                }
            } label: {
                Text("Sign Out")
            }
            .buttonStyle(LittleLemonButton())
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(SessionManager())
    }
}
