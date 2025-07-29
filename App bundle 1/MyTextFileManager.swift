//
//  TextFileManager.swift
//  App bundle 1
//
//  Created by lilit on 29.07.25.
//

import Foundation

class MyTextFileManager {

    private static let fileName = "note.txt"

    private static func getDocumentURL(for fileName: String) -> URL? {
        let fileManager = FileManager.default
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName)
    }

    static func save(text: String) -> Bool {
        guard let fileURL = getDocumentURL(for: fileName) else { return false }
        do {
            try text.write(to: fileURL, atomically: true, encoding: .utf8)
            return true
        } catch {
            print("MyTextFileManager Save Error: \(error)")
            return false
        }
    }

    static func read() -> String? {
        guard let fileURL = getDocumentURL(for: fileName) else { return nil }
        do {
            return try String(contentsOf: fileURL, encoding: .utf8)
        } catch {
            print("MyTextFileManager Read Error: \(error)")
            return nil
        }
    }
}

