//
//  OnboardingView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 03/05/2023.
//

import SwiftUI

let keyFirstName = "first name key"
let keyLastName = "last name key"
let keyEmail = "email key"

struct OnboardingView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    @State private var selectedSheet = ""
    @State private var showingWebSheet = false
    
    
    var body: some View {
        VStack {
            NavigationStack {
                OnboardingHomeView()
            }
        }
        .accentColor(Color(red: 73/255, green: 94/255, blue: 87/255))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
