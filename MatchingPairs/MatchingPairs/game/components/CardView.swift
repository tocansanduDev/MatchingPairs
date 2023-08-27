//
//  CardView.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import SwiftUI

struct CardView: View {
    @Binding var card: Card
    
    let onDidFinishInteraction: () -> Void
    
    var body: some View {
        card.color
            .overlay(content: overlay)
            .cornerRadius(10)
            .frame(height: 120)
            .rotation3DEffect(angle, axis: (x: 0, y: 1, z: 0))
            .onTapGesture(perform: action)
    }
    
    private var angle: Angle {
        .degrees(card.isFlipped ? 0 : 180)
    }
    
    private func overlay() -> some View {
        Text(card.isFlipped ? card.faceSymbol : card.symbol)
    }
    
    private func action() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            card.isFlipped.toggle()
            onDidFinishInteraction()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(Card(symbol: "🎈", faceSymbol: "🟡", color: .green)) { card in
            CardView(card: card, onDidFinishInteraction: {})
                .frame(width: 100, height: 125)
        }
    }
}

