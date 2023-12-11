//
//  StoreKitManager.swift
//  Moment
//
//  Created by Gleb on 07.11.2023.
//

import Foundation
import StoreKit

class StoreKitManager: ObservableObject  {
    
    @Published var storeProducts: [Product] = []
    @Published var purchasedProducts: [Product] = []
    
    private let productDict: [String : String]
    
    init() {
        
        if let plistPath = Bundle.main.path(forResource: "PropertyList", ofType: "plist"),
            
            let plist = FileManager.default.contents(atPath: plistPath) {
            
            productDict = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String : String]) ?? [:]
        } else {
            productDict = [:]
        }
        
        Task {
            await requestProducts()
        }
    }
    
    @MainActor
    func requestProducts() async {
        
        do {
            storeProducts = try await Product.products(for: productDict.values)
        } catch {
            print ("Failed - error retrieving products \(error)")
        }
        
    }
    
}
