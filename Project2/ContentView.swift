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
    @State private var wrongCountry = ""
    
    
    @State private var turnCount = 0
    @State private var gameOver = false




    
    var body: some View {
        
        ZStack{
//            LinearGradient(gradient: Gradient(colors: [.mint, .black]), startPoint: .top, endPoint: .bottom)
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.20),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                           center: .top,
                           startRadius: 50,
                           endRadius: 800).ignoresSafeArea()
            
            
            
            VStack{
                Spacer()
                Text("Guess the flag!").foregroundColor(.white).font(.largeTitle.bold())
                Spacer()
                VStack(spacing: 30){
                    VStack{
                        Text("Tap the flag of").foregroundStyle(.secondary).font(.subheadline).fontWeight(.heavy)
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
                    
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()

                Text("Score: \(score)").foregroundColor(.white).font(.largeTitle.bold())
                Spacer()

            }.padding()


        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Thats the flag of \(wrongCountry)! Your score is \(score)")
        }
        .alert("Game Over", isPresented: $gameOver){
            Button("Reset", action: reset)
        } message: {
            Text("Game Over! Your score is \(score)")
        }
        
        }
    
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        gameOver=false
        score=0
        turnCount=0
    }
    
    func flagTapped(_ number : Int) {
        
        if number == correctAnswer {
              scoreTitle = "Correct"
            score += 1
            turnCount += 1
          } else {
              scoreTitle = "Wrong"
              wrongCountry = countries[number]
              turnCount += 1
          }

        showingScore = true
        if turnCount==5{
            gameOver = true
        }
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
