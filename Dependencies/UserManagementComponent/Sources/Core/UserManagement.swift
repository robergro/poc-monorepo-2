/// A struct representing a user in the system
/// Contains basic user information including identification and contact details
public struct User {
    /// The unique identifier for the user
    public let id: String

    /// The user's full name
    public let name: String

    /// The user's email address
    public let email: String

    /// Initializes a new User instance
    /// - Parameters:
    ///   - id: The unique identifier for the user
    ///   - name: The user's full name
    ///   - email: The user's email address
    public init(id: String, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
}

/// A struct representing user credentials
/// Used for authentication purposes
public struct UserCredentials {
    /// The username for authentication
    public let username: String

    /// The password for authentication
    public let password: String

    /// Initializes a new UserCredentials instance
    /// - Parameters:
    ///   - username: The username for authentication
    ///   - password: The password for authentication
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

/// A struct representing a user profile with extended information
/// Contains additional details beyond basic user information
public struct UserProfile {
    /// The associated user
    public let user: User

    /// The user's biography or description
    public let bio: String

    /// The user's date of birth
    public let dateOfBirth: String

    /// Initializes a new UserProfile instance
    /// - Parameters:
    ///   - user: The associated user
    ///   - bio: The user's biography or description
    ///   - dateOfBirth: The user's date of birth
    public init(user: User, bio: String, dateOfBirth: String) {
        self.user = user
        self.bio = bio
        self.dateOfBirth = dateOfBirth
    }
}

// sourcery: AutoMockable, AutoMockTest
protocol UMGetBorderUseCaseable {
    func execute(
        theme: Bool
    ) -> String
}
