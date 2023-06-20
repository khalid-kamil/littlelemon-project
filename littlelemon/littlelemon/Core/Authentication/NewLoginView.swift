//
//  Created by Khalid Kamil on 20/06/2023.
//

import SwiftUI

struct NewLoginView: View {
    var body: some View {
        NavigationStack {
            VStack {
                // image
                Image("iccoLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100, maxHeight: 120)
                    .padding(.vertical, 32)
                // form fields
                
                // sign in button
                
                Spacer()
                
                // sign up button
            }
        }
    }
}

struct NewLoginView_Previews: PreviewProvider {
    static var previews: some View {
        NewLoginView()
    }
}
