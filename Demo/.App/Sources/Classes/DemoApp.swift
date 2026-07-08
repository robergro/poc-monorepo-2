//
//  DemoApp.swift
//  SparkDemo
//
//  Created by robin.lemaire on 14/01/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

// TODO: retester les TextField et textInput après avoir mis le thème dans l'init en Swiftui

import SwiftUI
import SparkDemo

//@_exported import OrderManagementComponent

@main
struct DemoApp: App {

    // MARK: - Initialization

    init() {
        // Configurations
//        DemoConfiguration.load()
//        SparkConfiguration.load()
        

        let test = OrderItem(productId: "az", quantity: 1, unitPrice: 2)
    }

    // MARK: - View

    var body: some Scene {
        WindowGroup {
            Text("Hey")
//            MainView()
        }
    }
}
