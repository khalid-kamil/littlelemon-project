//
//  DishCoreDataEntityExtension.swift
//  littlelemon
//
//  Created by Khalid Kamil on 06/06/2023.
//

import Foundation
import CoreData

extension Dish {
    @discardableResult
    static func makePreview(count: Int, in context: NSManagedObjectContext) -> [Dish] {
        var objects = [Dish]()
        for i in 0..<count {
            let dish = Dish(context: context)
            dish.title = "Pasta \(i)"
            dish.price = "22"
            dish.category = "Dessert"
            dish.image = "https://images.pexels.com/photos/1640772/pexels-photo-1640772.jpeg?cs=srgb&dl=pexels-ella-olsson-1640772.jpg&fm=jpg"
            dish.dishDescription = "Description"
            objects.append(dish)
        }
        return objects
    }
    
    static func preview(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> Dish {
        return makePreview(count: 1, in: context)[0]
    }
    
    static func empty(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> Dish {
        return Dish(context: context)
    }
}

extension Dish {
    static func formatPrice(_ price: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        
        let number = Float(price) ?? 0
        let formattedValue = formatter.string(for: number)!
        return formattedValue
    }
}
