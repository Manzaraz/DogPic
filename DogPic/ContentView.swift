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
    
    @StateObject var DogVM = DogViewModel()
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
            
            if DogVM.imageURL != "" {
                AsyncImage(url: URL(string: DogVM.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 15)
                        .minimumScaleFactor(0.5)
                        .animation(.easeInOut, value: image)
                        
                } placeholder: {
                    ZStack {
                        ProgressView()
                            .tint(.red)

                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.brown)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 15)
                        
                    }
                }
                
            }

            
            Spacer()
            
            Button("Any Random Dog") {
                Task {
                    await DogVM.getData()
                }
            }
            .bold()
            .buttonStyle(.borderedProminent)
            .tint(.brown)
            .padding(.bottom)
            
            HStack (alignment: .firstTextBaseline) {
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
