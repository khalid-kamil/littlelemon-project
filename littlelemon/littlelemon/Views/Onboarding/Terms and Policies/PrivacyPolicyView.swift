//
//  PrivacyPolicyView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 15/05/2023.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Privacy Policy")
                    .font(.title)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eu lectus eu felis cursus varius. In in mauris mauris. Nulla semper ex at mauris maximus, at tincidunt ex faucibus. Quisque ac laoreet sem. Mauris sagittis ipsum vitae tempus pharetra. Vivamus sollicitudin interdum tellus in facilisis. Vestibulum condimentum nisi ut mi scelerisque, id iaculis tellus faucibus.")
                
                // Add more privacy policy text here...
            }
            .padding()
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
