//
//  JsonHelper.swift
//  movie-list-appTests
//
//  Created by Jadhav, Dhananjay on 07/06/24.
//

import Foundation

func loadJSONData(from filename: String) -> Data? {
    // Get the URL of the JSON file
    if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
        do {
            // Read the contents of the file
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Error reading JSON file:", error)
        }
    } else {
        print("JSON file not found in bundle.")
    }
    return nil
}
