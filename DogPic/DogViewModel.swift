//
//  DogViewModel.swift
//  DogPic
//
//  Created by Christian Manzaraz on 10/01/2024.
//

import Foundation

@MainActor
class DogViewModel: ObservableObject {
    struct Result: Codable {
        var message: String
    }
    
    @Published var imageURL = ""
    
    var urlString = "https://dog.ceo/api/breeds/image/random"
    
    func getData() async {
        print("🕸️ We're accessing the URL \(urlString)")
        
        // Convert the urlString to the special URL type
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: We Culdn't create a URL from \(urlString).")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let result = try? JSONDecoder().decode(Result.self, from: data) else {
                print("😡JSON ERROR: we couldn't decode  returned JSON data from \(urlString).")
                return
            }
            imageURL = result.message
            print(imageURL)
            print("The image URL is: \(imageURL)")
            
        } catch {
            print("😡 ERROR: Could notuse URL at \(urlString) to get data & response.")
        }
    }
    
}
