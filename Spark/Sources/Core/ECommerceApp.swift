@_exported import UserManagementComponent
@_exported import ProductCatalogComponent
@_exported import OrderManagementComponent

/// A struct representing a complete shopping session
/// Combines user, products, and order information from all three modules
public struct ShoppingSession {
    /// The user making the purchase
    public let user: User

    /// The user's credentials for authentication
    public let credentials: UserCredentials

    /// The list of products being viewed or purchased
    public let products: [Product]

    /// The shopping cart inventory
    public let cart: [Inventory]

    /// Initializes a new ShoppingSession instance
    /// - Parameters:
    ///   - user: The user making the purchase
    ///   - credentials: The user's credentials for authentication
    ///   - products: The list of products being viewed or purchased
    ///   - cart: The shopping cart inventory
    public init(user: User, credentials: UserCredentials, products: [Product], cart: [Inventory]) {
        self.user = user
        self.credentials = credentials
        self.products = products
        self.cart = cart
    }
}

/// A struct representing a completed purchase transaction
/// Integrates user profile, order details, and product information
public struct PurchaseTransaction {
    /// The user profile of the customer
    public let userProfile: UserProfile

    /// The order created from the purchase
    public let order: Order

    /// The items included in the order
    public let orderItems: [OrderItem]

    /// The products that were purchased
    public let products: [Product]

    /// Initializes a new PurchaseTransaction instance
    /// - Parameters:
    ///   - userProfile: The user profile of the customer
    ///   - order: The order created from the purchase
    ///   - orderItems: The items included in the order
    ///   - products: The products that were purchased
    public init(userProfile: UserProfile, order: Order, orderItems: [OrderItem], products: [Product]) {
        self.userProfile = userProfile
        self.order = order
        self.orderItems = orderItems
        self.products = products
    }

    /// Calculates the total amount of all order items
    /// - Returns: The sum of all order item totals
    public func calculateTotal() -> Double {
        return orderItems.reduce(0.0) { $0 + $1.totalPrice() }
    }
}

/// A struct representing product catalog management for a user
/// Links users to product categories and inventory
public struct UserCatalogView {
    /// The user viewing the catalog
    public let user: User

    /// The categories available to browse
    public let categories: [Category]

    /// The products in each category
    public let products: [Product]

    /// The inventory status for products
    public let inventoryStatus: [Inventory]

    /// Initializes a new UserCatalogView instance
    /// - Parameters:
    ///   - user: The user viewing the catalog
    ///   - categories: The categories available to browse
    ///   - products: The products in each category
    ///   - inventoryStatus: The inventory status for products
    public init(user: User, categories: [Category], products: [Product], inventoryStatus: [Inventory]) {
        self.user = user
        self.categories = categories
        self.products = products
        self.inventoryStatus = inventoryStatus
    }

    /// Finds available products based on inventory
    /// - Returns: Array of products that have inventory quantity greater than 0
    public func availableProducts() -> [Product] {
        let availableProductIds = inventoryStatus.filter { $0.quantity > 0 }.map { $0.productId }
        return products.filter { availableProductIds.contains($0.id) }
    }
}
