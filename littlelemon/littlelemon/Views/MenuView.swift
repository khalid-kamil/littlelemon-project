//
//  MenuView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 17/05/2023.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            HeaderView()
            List {
                
            }
        }
        .onAppear {
            getMenuData()
        }
    }
    
    func getMenuData() {
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        
        var task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            let data = data
            print(String(describing: data))
        }
        task.resume()
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
