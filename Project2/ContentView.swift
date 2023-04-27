//
//  ContentView.swift
//  Project2
//
//  Created by Gerard White on 25/04/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.mint, .black]), startPoint: .top, endPoint: .bottom)
            
//            RadialGradient(
            
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of").foregroundColor(.white).font(.subheadline).fontWeight(.heavy)
                    Text(countries[correctAnswer]).foregroundColor(.white).font(.largeTitle).fontWeight(.bold)
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                    }
                    .shadow(radius: 5.0)
                    .clipShape(Capsule())
                }
                
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        }
    
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number : Int) {
        
        if number == correctAnswer {
              scoreTitle = "Correct"
            score += 1
          } else {
              scoreTitle = "Wrong"
          }

        showingScore = true
    }
}


func printWarning() -> Void {
    print("Whatever")
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
