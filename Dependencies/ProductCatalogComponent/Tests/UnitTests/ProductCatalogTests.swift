import Testing
@testable import ProductCatalogComponent

@Test func testProductInitialization() async throws {
    let product = Product(id: "P001", name: "Laptop", price: 999.99, description: "High-performance laptop")

    #expect(product.id == "P001")
    #expect(product.name == "Laptop")
    #expect(product.price == 999.99)
    #expect(product.description == "High-performance laptop")
}

@Test func testCategoryInitialization() async throws {
    let category = Category(id: "C001", name: "Electronics", parentId: nil)

    #expect(category.id == "C001")
    #expect(category.name == "Electronics")
    #expect(category.parentId == nil)
}

@Test func testCategoryWithParent() async throws {
    let category = Category(id: "C002", name: "Computers", parentId: "C001")

    #expect(category.id == "C002")
    #expect(category.name == "Computers")
    #expect(category.parentId == "C001")
}

@Test func testInventoryInitialization() async throws {
    let inventory = Inventory(productId: "P001", quantity: 50, location: "Warehouse A")

    #expect(inventory.productId == "P001")
    #expect(inventory.quantity == 50)
    #expect(inventory.location == "Warehouse A")
}
