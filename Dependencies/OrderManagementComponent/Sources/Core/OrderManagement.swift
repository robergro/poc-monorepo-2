/// A struct representing an order in the system
/// Contains order details and status information
public struct Order {
    /// The unique identifier for the order
    public let id: String

    /// The customer identifier who placed the order
    public let customerId: String

    /// The total amount of the order
    public let totalAmount: Double

    /// The current status of the order
    public let status: OrderStatus

    /// Initializes a new Order instance
    /// - Parameters:
    ///   - id: The unique identifier for the order
    ///   - customerId: The customer identifier who placed the order
    ///   - totalAmount: The total amount of the order
    ///   - status: The current status of the order
    public init(id: String, customerId: String, totalAmount: Double, status: OrderStatus) {
        self.id = id
        self.customerId = customerId
        self.totalAmount = totalAmount
        self.status = status
    }
}

/// A struct representing the status of an order
/// Tracks the current state in the order lifecycle
public struct OrderStatus {
    /// The status code
    public let code: String

    /// The human-readable status description
    public let description: String

    /// Initializes a new OrderStatus instance
    /// - Parameters:
    ///   - code: The status code
    ///   - description: The human-readable status description
    public init(code: String, description: String) {
        self.code = code
        self.description = description
    }
}

/// A struct representing an item within an order
/// Contains product and quantity information
public struct OrderItem {
    /// The product identifier
    public let productId: String

    /// The quantity ordered
    public let quantity: Int

    /// The price per unit at the time of order
    public let unitPrice: Double

    /// Initializes a new OrderItem instance
    /// - Parameters:
    ///   - productId: The product identifier
    ///   - quantity: The quantity ordered
    ///   - unitPrice: The price per unit at the time of order
    public init(productId: String, quantity: Int, unitPrice: Double) {
        self.productId = productId
        self.quantity = quantity
        self.unitPrice = unitPrice
    }

    /// Calculates the total price for this order item
    /// - Returns: The total price (quantity × unitPrice)
    public func totalPrice() -> Double {
        return Double(quantity) * unitPrice
    }
}

// sourcery: AutoMockable, AutoMockTest
protocol OMGetBorderUseCaseable {
    func execute(
        theme: Bool
    ) -> String
}
