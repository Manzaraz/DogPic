//
//  ContentView.swift
//  DogPic
//
//  Created by Christian Manzaraz on 10/01/2024.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    enum Breed: String, CaseIterable {
        case boxer, englishBulldog = "bulldog/english", chihuahua, goldenRetriever = "retriever/golden", beagle, pug, labrador, maltese, bassetHound = "hound/basset", pointer
    }

    
    @StateObject var DogVM = DogViewModel()
    @State private var selectedBreed: Breed = .maltese
    @State private var audioPlayer: AVAudioPlayer!
    
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
                DogVM.urlString = "https://dog.ceo/api/breeds/image/random"
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
                    DogVM.urlString = "https://dog.ceo/api/breed/\(selectedBreed.rawValue)/images/random"
                    Task {
                        await DogVM.getData()
                    }

                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
    
                Picker("", selection: $selectedBreed) {
                    ForEach(Breed.allCases, id: \.self) { breed in
                        Text(breed.rawValue.split(separator: "/").reversed().joined(separator: " ").capitalized)
                    }
                }
                
            }
            .bold()
            .tint(.brown)
        }
        .padding()
        .onAppear {
            playSound(soundName: "bark")
        }
    }
    
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else { 
            print("🤬 ERROR: Could not read file named \(soundName)")
            return
        }
        
        do {
            audioPlayer =  try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("🤬 ERROR:  \(error.localizedDescription) creating audioPlayer.")
        }
    }
}

#Preview {
    ContentView()
}
