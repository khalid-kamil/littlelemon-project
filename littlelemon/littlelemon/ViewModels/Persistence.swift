import CoreData
import Foundation
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "MenuDatabase")
        if EnvironmentValues.isPreview {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: {_,_ in })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func clear() {
        // Delete all dishes from the store
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let _ = try? container.persistentStoreCoordinator.execute(deleteRequest, with: container.viewContext)
    }
    
    func getMenuData() {
        // clear database  before saving menu list each time
        clear()
        
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // Parsing response into models using JSONDecoder
            if let data = data {
                let decoder = JSONDecoder()
                guard let result = try? decoder.decode(MenuList.self, from: data) else {
                    print("JSON decoding error")
                    return
                }
                for item in result.menu {
                    let oneDish = Dish(context: container.viewContext)
                    oneDish.title = item.title
                    oneDish.image = item.image
                    oneDish.price = item.price
                    oneDish.category = item.category
                    oneDish.dishDescription = item.description
                }
                try? container.viewContext.save()
                print("View Context saved.")
            }
        }
        task.resume()
        
    }
}

extension EnvironmentValues {
    static var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNNING_FOR_PREVIEWS"] == "1"
    }
}
