//
//  ContentView.swift
//  DogPic
//
//  Created by Christian Manzaraz on 10/01/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("🐶Dog Pics!")
                .font(Font.custom("Avenir Next Condensed", size: 60))
                .bold()
                .foregroundStyle(.brown)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Spacer()
            
            Button {
                //TODO: Add action here
            } label: {
                Text("Any Random Dog")
                    .bold()
            }
            .buttonStyle(.borderedProminent)
            .tint(.brown)
            .padding(.bottom)
                
            
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
