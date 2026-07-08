import Testing
@testable import Common

struct StringExtensionsTests {

    @Test("capitalizedFirst returns capitalized string")
    func testCapitalizedFirst() {
        #expect("hello world".capitalizedFirst() == "Hello world")
    }

    @Test("capitalizedFirst handles uppercase input")
    func testCapitalizedFirstWithUppercase() {
        #expect("HELLO WORLD".capitalizedFirst() == "Hello world")
    }

    @Test("capitalizedFirst handles mixed case")
    func testCapitalizedFirstWithMixedCase() {
        #expect("hElLo WoRlD".capitalizedFirst() == "Hello world")
    }

    @Test("capitalizedFirst handles single character")
    func testCapitalizedFirstSingleCharacter() {
        #expect("h".capitalizedFirst() == "H")
    }

    @Test("capitalizedFirst handles empty string")
    func testCapitalizedFirstEmptyString() {
        #expect("".capitalizedFirst() == "")
    }

    @Test("capitalizedFirst handles already capitalized string")
    func testCapitalizedFirstAlreadyCapitalized() {
        #expect("Hello world".capitalizedFirst() == "Hello world")
    }
}
