import Testing
@testable import ECommerceApp
import UserManagementComponent
import ProductCatalogComponent
import OrderManagementComponent

@Test func testShoppingSessionInitialization() async throws {
    let user = User(id: "U001", name: "Alice Johnson", email: "alice@example.com")
    let credentials = UserCredentials(username: "alice", password: "secret123")
    let products = [
        Product(id: "P001", name: "Laptop", price: 999.99, description: "Gaming laptop"),
        Product(id: "P002", name: "Mouse", price: 29.99, description: "Wireless mouse")
    ]
    let cart = [
        Inventory(productId: "P001", quantity: 1, location: "Cart"),
        Inventory(productId: "P002", quantity: 2, location: "Cart")
    ]

    let session = ShoppingSession(user: user, credentials: credentials, products: products, cart: cart)

    #expect(session.user.name == "Alice Johnson")
    #expect(session.credentials.username == "alice")
    #expect(session.products.count == 2)
    #expect(session.cart.count == 2)
}

@Test func testPurchaseTransactionInitialization() async throws {
    let user = User(id: "U002", name: "Bob Smith", email: "bob@example.com")
    let userProfile = UserProfile(user: user, bio: "Tech enthusiast", dateOfBirth: "1985-06-15")
    let status = OrderStatus(code: "CONFIRMED", description: "Order confirmed")
    let order = Order(id: "ORD001", customerId: "U002", totalAmount: 1099.98, status: status)
    let orderItems = [
        OrderItem(productId: "P001", quantity: 1, unitPrice: 999.99),
        OrderItem(productId: "P002", quantity: 2, unitPrice: 49.99)
    ]
    let products = [
        Product(id: "P001", name: "Laptop", price: 999.99, description: "Gaming laptop")
    ]

    let transaction = PurchaseTransaction(
        userProfile: userProfile,
        order: order,
        orderItems: orderItems,
        products: products
    )

    #expect(transaction.userProfile.user.name == "Bob Smith")
    #expect(transaction.order.id == "ORD001")
    #expect(transaction.orderItems.count == 2)
    #expect(transaction.products.count == 1)
}

@Test func testPurchaseTransactionCalculateTotal() async throws {
    let user = User(id: "U003", name: "Charlie", email: "charlie@example.com")
    let userProfile = UserProfile(user: user, bio: "Customer", dateOfBirth: "1990-01-01")
    let status = OrderStatus(code: "PENDING", description: "Pending payment")
    let order = Order(id: "ORD002", customerId: "U003", totalAmount: 0.0, status: status)
    let orderItems = [
        OrderItem(productId: "P001", quantity: 2, unitPrice: 100.0),
        OrderItem(productId: "P002", quantity: 3, unitPrice: 50.0)
    ]
    let products: [Product] = []

    let transaction = PurchaseTransaction(
        userProfile: userProfile,
        order: order,
        orderItems: orderItems,
        products: products
    )

    let total = transaction.calculateTotal()
    #expect(total == 350.0)
}

@Test func testUserCatalogViewInitialization() async throws {
    let user = User(id: "U004", name: "Diana", email: "diana@example.com")
    let categories = [
        Category(id: "C001", name: "Electronics"),
        Category(id: "C002", name: "Books")
    ]
    let products = [
        Product(id: "P001", name: "Phone", price: 699.99, description: "Smartphone"),
        Product(id: "P002", name: "Novel", price: 19.99, description: "Fiction book")
    ]
    let inventoryStatus = [
        Inventory(productId: "P001", quantity: 10, location: "Warehouse A"),
        Inventory(productId: "P002", quantity: 0, location: "Warehouse B")
    ]

    let catalogView = UserCatalogView(
        user: user,
        categories: categories,
        products: products,
        inventoryStatus: inventoryStatus
    )

    #expect(catalogView.user.name == "Diana")
    #expect(catalogView.categories.count == 2)
    #expect(catalogView.products.count == 2)
    #expect(catalogView.inventoryStatus.count == 2)
}

@Test func testUserCatalogViewAvailableProducts() async throws {
    let user = User(id: "U005", name: "Eve", email: "eve@example.com")
    let products = [
        Product(id: "P001", name: "Phone", price: 699.99, description: "Smartphone"),
        Product(id: "P002", name: "Tablet", price: 499.99, description: "Tablet device"),
        Product(id: "P003", name: "Watch", price: 299.99, description: "Smart watch")
    ]
    let inventoryStatus = [
        Inventory(productId: "P001", quantity: 5, location: "Warehouse A"),
        Inventory(productId: "P002", quantity: 0, location: "Warehouse B"),
        Inventory(productId: "P003", quantity: 3, location: "Warehouse C")
    ]

    let catalogView = UserCatalogView(
        user: user,
        categories: [],
        products: products,
        inventoryStatus: inventoryStatus
    )

    let available = catalogView.availableProducts()
    #expect(available.count == 2)
    #expect(available.contains { $0.id == "P001" })
    #expect(available.contains { $0.id == "P003" })
    #expect(!available.contains { $0.id == "P002" })
}
