import Testing
@testable import UserManagementComponent

@Test func testUserInitialization() async throws {
    let user = User(id: "123", name: "John Doe", email: "john@example.com")

    #expect(user.id == "123")
    #expect(user.name == "John Doe")
    #expect(user.email == "john@example.com")
}

@Test func testUserCredentialsInitialization() async throws {
    let credentials = UserCredentials(username: "johndoe", password: "secret123")

    #expect(credentials.username == "johndoe")
    #expect(credentials.password == "secret123")
}

@Test func testUserProfileInitialization() async throws {
    let user = User(id: "456", name: "Jane Smith", email: "jane@example.com")
    let profile = UserProfile(user: user, bio: "Software developer", dateOfBirth: "1990-01-01")

    #expect(profile.user.id == "456")
    #expect(profile.user.name == "Jane Smith")
    #expect(profile.bio == "Software developer")
    #expect(profile.dateOfBirth == "1990-01-01")
}

//@Test func testFailureUserrMan()  {
//    #expect(1 == 2)
//}

