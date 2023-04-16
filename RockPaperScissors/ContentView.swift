//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Mykola Zakluka on 16.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isWin = false
    @State private var isReload = false
    @State private var isFinal = false
    @State private var score = 0
    @State private var counGame = 0
    @State private var programChoise = Int.random(in: 0...2)
    @State private var statusText = "Choise to start"
    
    private let variants = ["✊", "✋", "✌️"]
    private let textVariants = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        ZStack {
            Color(red: 74 / 255, green: 0, blue: 130 / 255)
                .ignoresSafeArea()
            
            VStack {
                Text("Rock Paper Scissors")
                    .font(.largeTitle)
                    .foregroundColor(.yellow)
                    .bold()
                
                Spacer()
                
                Text("You score is \(score)")
                    .textStyle()
                
                Spacer()
                
                VStack(spacing: 10) {
                    Text(statusText)
                        .font(.title2)
                        .textStyle()
                    
                    HStack {
                        if counGame > 0 {
                            if isReload {
                                Text("Play again")
                                    .textStyle()
                            } else {
                                Text("You:")
                                    .textStyle()
                                
                                Text(isWin ? "Win" : "Lose")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(isWin ? .green : .red)
                            }
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    ForEach(0..<3, id: \.self) { number in
                        Button(action: {
                            tapIcon(number)
                        }) {
                            TextButton(text: variants[number])
                        }
                        .padding(5)
                    }
                }
                
                Spacer()
            }
        }
        .alert("You score: \(score)", isPresented: $isFinal) {
            Button("Restart", action: restart)
        }
    }
    
    func tapIcon(_ number: Int) {
        switch number {
        case 0:
            switch programChoise {
            case 0:
                reGame()
            case 1:
                lose()
            case 2:
                win()
            default:
                reGame()
            }
        case 1:
            switch programChoise {
            case 0:
                win()
            case 1:
                reGame()
            case 2:
                lose()
            default:
                reGame()
            }
        case 2:
            switch programChoise {
            case 0:
                lose()
            case 1:
                win()
            case 2:
                reGame()
            default:
                reGame()
            }
        default:
            reGame()
        }
    }
    
    private func reGame() {
        reloadStates()
        isReload = true
    }
    
    private func win() {
        reloadStates()
        score += 1
        isWin = true
        isReload = false
    }
    
    private func lose() {
        reloadStates()
        score = score > 0 ? score - 1 : 0
        isWin = false
        isReload = false
    }
    
    private func reloadStates() {
        if counGame == 9 {
            isFinal = true
        }
        counGame += 1
        statusText = "Your opponent has chosen \(textVariants[programChoise])"
        programChoise = Int.random(in: 0...2)
    }
    
    func restart() {
        programChoise = Int.random(in: 0...2)
        statusText = "Choise to start"
        counGame = 0
        score = 0
    }
}

struct TextButton: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .frame(width: 100, height: 100)
            .cornerRadius(20)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 3)
            }
    }
}

struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.yellow)
            .bold()
    }
}

extension View {
    func textStyle () -> some View {
        modifier(TextStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
