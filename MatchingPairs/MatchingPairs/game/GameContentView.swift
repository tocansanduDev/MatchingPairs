//
//  GameView.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import SwiftUI
import MatchingPairsPackage

struct Game {
    struct ContentView: View {
        @EnvironmentObject var viewModel: ViewModel
        @EnvironmentObject private var orientationInfo: OrientationInfo
        @Environment(\.colorScheme) private var colorScheme
        
        var body: some View {
            VStack(spacing: 0) {
                if orientationInfo.orientation == .portrait {
                    scoreView
                        .padding(.bottom)
                }
                Group {
                    if let completion = viewModel.completionState {
                        congratulationMessageView(of: completion.message)
                    } else {
                        gridView
                    }
                }
                .frame(maxHeight: .infinity)
                .padding(.bottom)
                HStack {
                    if orientationInfo.orientation == .landscape {
                        timerView
                            .padding(.leading)
                        Spacer()
                            .frame(maxWidth: 60)
                    }
                    resetButton
                        .frame(maxWidth: .infinity)
                    if orientationInfo.orientation == .landscape {
                        scoreView
                    }
                }
                .padding(.horizontal)
                if orientationInfo.orientation == .portrait {
                    timerView
                }
            }
            .padding(.vertical)
            .navigationTitle(viewModel.themeTitle)
            .onAppear(perform: viewModel.reset)
        }
        
        private var scoreView: some View {
            Text("Score: \(viewModel.score)")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
                .monospacedDigit()
                .frame(maxWidth: 200)
        }
        
        private func congratulationMessageView(of message: String) -> some View {
            Text(message)
                .font(.largeTitle)
                .fontWeight(.bold)
                .transition(.scale(scale: 0.3))
        }
        
        private var gridView: some View {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80, maximum: 80))], spacing: 20) {
                ForEach($viewModel.cards) { $card in
                    CardView(card: $card, onDidFinishInteraction: viewModel.evaluate)
                        .disabled(viewModel.isEvaluating)
                }
            }
        }
        
        private var resetButton: some View {
            Button(action: viewModel.reset) {
                Text("Reset")
                    .foregroundColor(.red)
                    .padding(EdgeInsets(top: 6, leading: 56, bottom: 6, trailing: 56))
            }
            .buttonStyle(.bordered)
        }
        
        private var timerView: some View {
            InLineProgressView(progress: viewModel.progress, colorScheme: colorScheme)
                .opacity(viewModel.completionState == nil ? 1 : 0)
                .frame(maxWidth: 140)
                .padding(.vertical)
        }
    }
}

struct Game_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Game.ContentView()
                .environmentObject(Game.ViewModel.mock)
                .environmentObject(OrientationInfo())
        }
    }
}
