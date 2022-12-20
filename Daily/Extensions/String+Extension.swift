import Foundation

extension String {
    var capitalizedFirstLetter: String {
        return prefix(1).capitalized + dropFirst()
    }

    var hashtags: [String] {
        let hashtagRegularExpression = "#[^\\s]+"
        return matches(hashtagRegularExpression)
    }

    func matches(_ regularExpression: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: regularExpression) else { return [] }
        let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
        return results.compactMap {
            guard let range = Range($0.range, in: self) else { return nil }
            return String(self[range])
        }
    }
}
