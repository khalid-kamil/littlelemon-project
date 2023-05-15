//
//  WebView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 13/05/2023.
//

import SwiftUI

struct WebSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var content: String
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 72))
                    .imageScale(.large)
                    .padding(.bottom)
                Text("Unable to load \(content)")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                Text("This page is a placeholder.")
                    .fontWeight(.medium)
                Spacer()
                Button("Press to dismiss") {
                    dismiss()
                }
                .font(.headline)
                .padding()
                .foregroundColor(.red)
            }
            .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebSheetView(content: .constant("Page"))
    }
}
