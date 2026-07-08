/// A struct representing a product in the catalog
/// Contains essential product information for e-commerce operations
public struct Product {
    /// The unique identifier for the product
    public let id: String

    /// The product name
    public let name: String

    /// The product price in decimal format
    public let price: Double

    /// The product description
    public let description: String

    /// Initializes a new Product instance
    /// - Parameters:
    ///   - id: The unique identifier for the product
    ///   - name: The product name
    ///   - price: The product price in decimal format
    ///   - description: The product description
    public init(id: String, name: String, price: Double, description: String) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
    }
}

/// A struct representing a product category
/// Used to organize products into logical groups
public struct Category {
    /// The unique identifier for the category
    public let id: String

    /// The category name
    public let name: String

    /// Optional parent category identifier for hierarchical structure
    public let parentId: String?

    /// Initializes a new Category instance
    /// - Parameters:
    ///   - id: The unique identifier for the category
    ///   - name: The category name
    ///   - parentId: Optional parent category identifier
    public init(id: String, name: String, parentId: String? = nil) {
        self.id = id
        self.name = name
        self.parentId = parentId
    }
}

/// A struct representing product inventory information
/// Tracks stock levels and availability
public struct Inventory {
    /// The product identifier
    public let productId: String

    /// The quantity available in stock
    public let quantity: Int

    /// The warehouse location
    public let location: String

    /// Initializes a new Inventory instance
    /// - Parameters:
    ///   - productId: The product identifier
    ///   - quantity: The quantity available in stock
    ///   - location: The warehouse location
    public init(productId: String, quantity: Int, location: String) {
        self.productId = productId
        self.quantity = quantity
        self.location = location
    }
}



// sourcery: AutoMockable, AutoMockTest
protocol PCGetBorderUseCaseable {
    func execute(
        theme: Bool
    ) -> String
}