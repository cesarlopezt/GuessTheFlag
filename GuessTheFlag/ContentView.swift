//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Cesar Lopez on 3/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var score = 0
    @State private var showingScore = false
    @State private var alertTitle = ""
    @State private var alertDescription = ""
    @State private var alertButtonText = "Continue"
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var questionNumber = 1
    
    var maxNumberOfQuestions = 5
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Text("Guess The flag")
                        .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    Spacer()
                    Text("Score: \(score)")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                }
                VStack (spacing: 20) {
                    VStack {
                        Group{
                            Text("Tap the flag of")
                                .font(.subheadline.weight(.heavy))
                            Text(countries[correctAnswer])
                                .font(.largeTitle.weight(.semibold))
                        }.foregroundColor(.white)
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                    HStack {
                        Spacer()
                        Text("# \(questionNumber) of \(maxNumberOfQuestions)")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.white)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
            }
            .padding([.leading, .trailing], 20)
        }.alert(alertTitle, isPresented: $showingScore) {
            Button(alertButtonText) {
                if (questionNumber == 1) {
                    score = 0
                }
            }
        } message: {
            Text(alertDescription)
        }
    }
    
    func flagTapped(_ index: Int) {
        if index == correctAnswer {
            alertTitle = "Correct!"
            alertDescription = ""
            score += 1
        } else {
            alertTitle = "Wrong"
            alertDescription = "That is the flag of \(countries[index])"
        }
        alertButtonText = "Continue"
        showingScore = true
        askQuestion()
    }
    
    func askQuestion() {
        if questionNumber < maxNumberOfQuestions {
            questionNumber += 1
        } else {
            questionNumber = 1
            alertTitle = "Good Job!"
            alertDescription = "Your score was \(score)/\(maxNumberOfQuestions)"
            alertButtonText = "Play again"
            showingScore = true
        }
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
