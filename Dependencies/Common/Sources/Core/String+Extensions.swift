import Foundation

public extension String {
    /// Returns a capitalized version of the string with the first letter uppercased
    /// and the rest lowercased.
    ///
    /// Example:
    /// ```swift
    /// "hello world".capitalizedFirst() // "Hello world"
    /// "HELLO WORLD".capitalizedFirst() // "Hello world"
    /// ```
    func capitalizedFirst() -> String {
        guard !isEmpty else { return self }
        return prefix(1).uppercased() + dropFirst().lowercased()
    }
}
