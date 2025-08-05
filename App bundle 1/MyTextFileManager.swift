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

    static func append(text: String) -> Bool {
        guard let fileURL = getDocumentURL(for: fileName) else { return false }
        let data = ("\n" + text).data(using: .utf8)!
        do {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                let fileHandle = try FileHandle(forWritingTo: fileURL)
                defer { fileHandle.closeFile() }
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
            } else {
                try data.write(to: fileURL)
            }
            return true
        } catch {
            print("MyTextFileManager Append Error: \(error)")
            return false
        }
    }
}
