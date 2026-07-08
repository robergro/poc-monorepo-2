// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// TODO: script pour générer ce fichier ?

let package = Package(
    name: "ECommerceApp",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "ECommerceApp",
            targets: ["ECommerceApp"]
        ),
        .library(
            name: "ECommerceAppTesting",
            targets: ["ECommerceAppTesting"]
        ), 
        .library(
            name: "Common",
            targets: ["Common"]
        ),
        .library(
            name: "CommonTesting",
            targets: ["CommonTesting"]
        ),
        .library(
            name: "OrderManagementComponent",
            targets: ["OrderManagementComponent"]
        ),
        .library(
            name: "OrderManagementComponentTesting",
            targets: ["OrderManagementComponentTesting"]
        ),
        .library(
            name: "ProductCatalogComponent",
            targets: ["ProductCatalogComponent"]
        ),
        .library(
            name: "ProductCatalogComponentTesting",
            targets: ["ProductCatalogComponentTesting"]
        ),
        .library(
            name: "UserManagementComponent",
            targets: ["UserManagementComponent"]
        ),
        .library(
            name: "UserManagementComponentTesting",
            targets: ["UserManagementComponentTesting"]
        ),
        .library(
            name: "SparkDemo",
            targets: ["SparkDemo"]
        ),
    ],
    targets: [
        //******
        // App
        .target(
            name: "ECommerceApp",
            dependencies: [
                "Common",
                "UserManagementComponent",
                "ProductCatalogComponent",
                "OrderManagementComponent",
            ],
            path: "Spark/Sources/Core"
        ),
        .target(
            name: "ECommerceAppTesting",
            dependencies: [
                "ECommerceApp"
            ],
            path: "Spark/Sources/Testing"
        ),
        .testTarget(
            name: "ECommerceAppTests",
            dependencies: [
                "ECommerceApp",
                "CommonTesting",
                "UserManagementComponentTesting",
                "ProductCatalogComponentTesting",
                "OrderManagementComponentTesting"
            ],
            path: "Spark/Tests/UnitTests"
        ),
        .testTarget(
            name: "ECommerceAppSnapshotsTests",
            dependencies: [
                "ECommerceApp",
                "CommonTesting",
                "UserManagementComponentTesting",
                "ProductCatalogComponentTesting",
                "OrderManagementComponentTesting"
            ],
            path: "Spark/Tests/SnapshotTests"
        ),
        //******

        //******
        // Common
        .target(
            name: "Common",
            path: "Dependencies/Common/Sources/Core"
        ),
        .target(
            name: "CommonTesting",
            dependencies: [
                "Common"
            ],
            path: "Dependencies/Common/Sources/Testing"
        ),
        .testTarget(
            name: "CommonTests",
            dependencies: [
                "Common",
                "CommonTesting"
            ],
            path: "Dependencies/Common/Tests/UnitTests"
        ),
        .testTarget(
            name: "CommonSnapshotsTests",
            dependencies: [
                "Common",
                "CommonTesting"
            ],
            path: "Dependencies/Common/Tests/SnapshotTests"
        ),
        //******

        //******
        // OrderManagement
        .target(
            name: "OrderManagementComponent",
            dependencies: [
                "Common"
            ],
            path: "Dependencies/OrderManagementComponent/Sources/Core"
        ),
        .target(
            name: "OrderManagementComponentTesting",
            dependencies: [
                "OrderManagementComponent"
            ],
            path: "Dependencies/OrderManagementComponent/Sources/Testing"
        ),
        .testTarget(
            name: "OrderManagementComponentTests",
            dependencies: [
                "OrderManagementComponent",
                "OrderManagementComponentTesting",
                "CommonTesting"
            ],
            path: "Dependencies/OrderManagementComponent/Tests/UnitTests"
        ),
        .testTarget(
            name: "OrderManagementSnapshotsTests",
            dependencies: [
                "OrderManagementComponent",
                "OrderManagementComponentTesting",
                "CommonTesting"
            ],
            path: "Dependencies/OrderManagementComponent/Tests/SnapshotTests"
        ),
        //******

        //******
        // Product Catalog
        .target(
            name: "ProductCatalogComponent",
            dependencies: [
                "Common"
            ],
            path: "Dependencies/ProductCatalogComponent/Sources/Core"
        ),
        .target(
            name: "ProductCatalogComponentTesting",
            dependencies: [
                "ProductCatalogComponent"
            ],
            path: "Dependencies/ProductCatalogComponent/Sources/Testing"
        ),
        .testTarget(
            name: "ProductCatalogComponentTests",
            dependencies: [
                "ProductCatalogComponent",
                "ProductCatalogComponentTesting",
                "CommonTesting"
            ],
            path: "Dependencies/ProductCatalogComponent/Tests/UnitTests"
        ),
        .testTarget(
            name: "ProductCatalogSnapshotsTests",
            dependencies: [
                "ProductCatalogComponent",
                "ProductCatalogComponentTesting",
                "CommonTesting"
            ],
            path: "Dependencies/ProductCatalogComponent/Tests/SnapshotTests"
        ),
        //******

        //******
        // User Management
        .target(
            name: "UserManagementComponent",
            dependencies: [
                "Common"
            ],
            path: "Dependencies/UserManagementComponent/Sources/Core"
        ),
        .target(
            name: "UserManagementComponentTesting",
            dependencies: [
                "UserManagementComponent"
            ],
            path: "Dependencies/UserManagementComponent/Sources/Testing"
        ),
        .testTarget(
            name: "UserManagementComponentTests",
            dependencies: [
                "UserManagementComponent",
                "UserManagementComponentTesting",
                "CommonTesting"
            ],
            path: "Dependencies/UserManagementComponent/Tests/UnitTests"
        ),
        .testTarget(
            name: "UserManagementSnapshotsTests",
            dependencies: [
                "UserManagementComponent",
                "UserManagementComponentTesting",
                "CommonTesting"
            ],
            path: "Dependencies/UserManagementComponent/Tests/SnapshotTests"
        ),
        //******

        //******
        // Demo
        .target(
            name: "SparkDemo",
            dependencies: [
                "ECommerceApp"
            ],
            path: "Demo/Sources"
        ),
        //******
    ]
)
