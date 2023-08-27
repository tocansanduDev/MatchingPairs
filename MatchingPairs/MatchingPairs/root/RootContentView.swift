//
//  ContentView.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 25.08.2023.
//

import SwiftUI

struct Root {
    struct ContentView: View {
        @EnvironmentObject var viewModel: ViewModel
        
        var body: some View {
            NavigationView {
                VStack {
                    Spacer()
                    titleView
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else if let message = viewModel.errorMessage {
                        Text(message)
                            .foregroundColor(Color.red)
                            .padding()
                        Button(action: viewModel.fetch) {
                            Text("Retry")
                        }
                    } else {
                        ForEach(viewModel.themeNames, id: \.self) { name in
                            NavigationLink(name, destination: destinationView(themeName: name))
                                .padding(4)
                        }
                    }
                    Spacer()
                    difficultyPickerView
                    totalScoreView
                }
                .onAppear(perform: viewModel.fetchScore)
                .navigationTitle("Matching Pairs")
            }
        }
        
        private var titleView: some View {
            Text("Themes")
                .fontWeight(.bold)
                .font(.title3)
                .foregroundStyle(
                    .linearGradient(
                        colors: [.yellow, .blue],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        }
        
        private var difficultyPickerView: some View {
            Picker("", selection: $viewModel.difficyltyLevel) {
                ForEach(DifficultyLevel.allCases, id: \.self) {
                    Text($0.description)
                }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 280)
        }
        
        private func destinationView(themeName: String) -> some View {
            Game.ContentView()
                .environmentObject(Game.ViewModel(
                    theme: viewModel.theme(for: themeName),
                    difficultyLevel: viewModel.difficyltyLevel)
                )
        }
        
        private var totalScoreView: some View {
            Text("Total score: \(viewModel.totalScore)")
                .font(.title3)
                .fontWeight(.bold)
                .padding()
        }
    }
}

struct Root_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Root.ContentView()
            .environmentObject(Root.ViewModel(requestManager: RequestManager()))
    }
}
