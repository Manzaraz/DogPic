//
//  ContentView.swift
//  DogPic
//
//  Created by Christian Manzaraz on 10/01/2024.
//

import SwiftUI

struct ContentView: View {
    enum Breed: String, CaseIterable {
        case boxer, bulldog, chihuahua, corgi, labradoodle, poodle, pug, retriver
    }
    
    @State private var selectedBreed: Breed = .boxer
    
    var body: some View {
        VStack {
            Text("🐶Dog Pics!")
                .font(Font.custom("Avenir Next Condensed", size: 60))
                .bold()
                .foregroundStyle(.brown)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Spacer()
            
            Button("Any Random Dog") {
                //TODO: Add search random dog functionality
            }
            .bold()
            .buttonStyle(.borderedProminent)
            .tint(.brown)
            .padding(.bottom)
            
            HStack {
                
                Button("Show Breed") {
                    //TODO: Add search random dog functionality
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom)
    
                Picker("", selection: $selectedBreed) {
                    ForEach(Breed.allCases, id: \.self) { breed in
                        Text(breed.rawValue.capitalized)
                    }
                }
            }
            .bold()
            .tint(.brown)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
