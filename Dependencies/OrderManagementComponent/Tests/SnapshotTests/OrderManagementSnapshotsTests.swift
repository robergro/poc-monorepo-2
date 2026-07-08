import Testing
@testable import OrderManagementComponent
import CommonTesting

@Test func testUIOrderStatusInitialization() async throws {
    let status = OrderStatus(code: .mock, description: "Order is pending")

    #expect(status.code == .mock)
    #expect(status.description == "Order is pending")
}

@Test func testUOrderInitialization() async throws {
    let status = OrderStatus(code: "CONFIRMED", description: "Order confirmed")
    let order = Order(id: "ORD001", customerId: "CUST123", totalAmount: 1299.99, status: status)

    #expect(order.id == "ORD001")
    #expect(order.customerId == "CUST123")
    #expect(order.totalAmount == 1299.99)
    #expect(order.status.code == "CONFIRMED")
}

@Test func testUOrderItemInitialization() async throws {
    let orderItem = OrderItem(productId: "P001", quantity: 2, unitPrice: 99.99)

    #expect(orderItem.productId == "P001")
    #expect(orderItem.quantity == 2)
    #expect(orderItem.unitPrice == 99.99)
}

@Test func testUOrderItemTotalPrice() async throws {
    let orderItem = OrderItem(productId: "P002", quantity: 3, unitPrice: 50.0)
    let totalPrice = orderItem.totalPrice()

    #expect(totalPrice == 150.0)
}
