//
//  HeaderView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 17/05/2023.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(spacing: 0) {
            topNav
            hero
        }
    }
}

private extension HeaderView {
    var topNav: some View {
        HStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(height: 36)
        }
        .padding(.bottom, 8)
    }
    
    var hero: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Little Lemon")
                .displayTitleStyle()
                .foregroundColor(Color("Primary 2"))
                .padding(.bottom, -16)
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Chicago")
                        .subtitleStyle()
                        .foregroundColor(.white)
                        .padding(.bottom, 16)
                    
                    Text("""
                            We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.
                            """)
                    .paragraphTextStyle()
                    .foregroundColor(.white)
                    .frame(maxWidth: 200)
                    .padding(.bottom, 32)
                }
                
                Image("Hero image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 140, height: 140, alignment: .center)
                    .cornerRadius(16)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 16)
        .background(Color("Primary 1"))
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
