import CoreData
import Foundation
import SwiftUI

struct FetchedObjects<T, Content>: View where T : NSManagedObject, Content : View {
    
  let content: ([T]) -> Content

  var request: FetchRequest<T>
  var results: FetchedResults<T>{ request.wrappedValue }
    
  init(
    predicate: NSPredicate = NSPredicate(value: true),
    sortDescriptors: [NSSortDescriptor] = [],
    @ViewBuilder content: @escaping ([T]) -> Content
  ) {
    self.content = content
    self.request = FetchRequest(
      entity: T.entity(),
      sortDescriptors: sortDescriptors,
      predicate: predicate
    )
  }
  
  
  var body: some View {
    self.content(results.map { $0 })
  }
}

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
