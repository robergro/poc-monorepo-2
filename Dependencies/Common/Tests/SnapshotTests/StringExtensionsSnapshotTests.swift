import Testing
@testable import Common

struct StringExtensionsSnapshotTests {

    @Test("capitalizedFirst returns capitalized string")
    func testUICapitalizedFirst() {
        #expect("hello world".capitalizedFirst() == "Hello world")
    }

    @Test("capitalizedFirst handles uppercase input")
    func testUICapitalizedFirstWithUppercase() {
        #expect("HELLO WORLD".capitalizedFirst() == "Hello world")
    }

    @Test("capitalizedFirst handles mixed case")
    func testUICapitalizedFirstWithMixedCase() {
        #expect("hElLo WoRlD".capitalizedFirst() == "Hello world")
    }

    @Test("capitalizedFirst handles single character")
    func testUICapitalizedFirstSingleCharacter() {
        #expect("h".capitalizedFirst() == "H")
    }

    @Test("capitalizedFirst handles empty string")
    func testUICapitalizedFirstEmptyString() {
        #expect("".capitalizedFirst() == "")
    }

    @Test("capitalizedFirst handles already capitalized string")
    func testUICapitalizedFirstAlreadyCapitalized() {
        #expect("Hello world".capitalizedFirst() == "Hello world")
    }
}
