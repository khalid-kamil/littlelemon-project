//
//  GameView.swift
//  littlelemon
//
//  Created by Khalid Kamil on 10/06/2023.
//

import SwiftUI

struct GameView: View {
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Rewards")
                        .font(.title)
                    Text("Play the Little Lemon games to earn rewards towards your orders.")
                        .font(.title2)
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                }
                
                ForEach(0..<3) { number in
                    Button {
                        // flag was tapped
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                    }
                    
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
