//
//  LocalFileManager.swift
//  wordle-ios
//
//  Created by Josep Bordes 2 on 12/2/22.
//

import Foundation

final class LocalFileManager {
    func retrieveSyncJson<R: Codable>(name: String, type _: R.Type) -> R? {
        // Json file of the project
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            return nil
        }

        do {
            let jsonData = try Data(contentsOf: url)
            let decodedObject = try JSONDecoder().decode(R.self, from: jsonData)
            return decodedObject
        } catch let error {
            print(error)
            return nil
        }
    }
}
