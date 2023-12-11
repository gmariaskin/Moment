
import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MomentCoreData")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
//
////MARK: - Create Account
//extension CoreDataManager {
//    
//    func createAccount(name: String, timestamp: Date) -> CDAccountModel {
//        let obj = CDAccountModel(context: persistentContainer.viewContext)
//        obj.name = name
//        obj.timestamp = timestamp
//        saveContext()
//        return obj
//    }
//    
//    func createAccountIfNoExist(name: String, timestamp: Date, completion: (Bool) -> Void?) {
//        let fetch = NSFetchRequest<CDAccountModel>(entityName: "CDAccountModel")
//        let predicate = NSPredicate(format: "name == %@", name)
//        fetch.predicate = predicate
//        do {
//            let existingAccount = try persistentContainer.viewContext.fetch(fetch)
//            if existingAccount.isEmpty {
//                let obj = CDAccountModel(context: persistentContainer.viewContext)
//                obj.name = name
//                obj.timestamp = timestamp
//                saveContext()
//            } else {
//                print("❌❌❌")
//            }
//            completion(existingAccount.isEmpty)
//        } catch {
//            print("Error fetching account: \(error)")
//        }
//    }
//}
//
////MARK: - Create Folder
//extension CoreDataManager {
//    
//    func createFolder(title: String, accounts: [CDAccountModel]) {
//        let fetch = NSFetchRequest<CDAccountModel>(entityName: "CDFolderModel")
//        let predicate = NSPredicate(format: "title == %@", title)
//        fetch.predicate = predicate
//        do {
//            let existingFolder = try persistentContainer.viewContext.fetch(fetch)
//            if existingFolder.isEmpty {
//                let folder = CDFolderModel(context: persistentContainer.viewContext)
//                folder.title = title
//                folder.accounts = NSSet(array: accounts)
//                saveContext()
//            } else {
//                print("Folder with title '\(title)' already exist.")
//            }
//        } catch {
//            print("Error fetching account: \(error)")
//        }
//    }
//}
//
////MARK: - Get all objects
//extension CoreDataManager {
//    
//    func getAccounts() -> [CDAccountModel] {
//        let fetch = NSFetchRequest<CDAccountModel>(entityName: "CDAccountModel")
//        do {
//            let objects = try persistentContainer.viewContext.fetch(fetch)
//            return objects
//        } catch {
//            fatalError("❌❌❌\(error)")
//        }
//    }
//}
//
////MARK: - Get all folders
//extension CoreDataManager {
//    
//    func getFolders() -> [CDFolderModel] {
//        let fetch = NSFetchRequest<CDFolderModel>(entityName: "CDFolderModel")
//        do {
//            let objects = try persistentContainer.viewContext.fetch(fetch)
//            return objects
//        } catch {
//            fatalError("❌❌❌\(error)")
//        }
//    }
//}
//
////MARK: - Delete object
//extension CoreDataManager {
//    func delete(object: CDAccountModel) {
//        persistentContainer.viewContext.delete(object)
//        saveContext()
//    }
//}
//
////MARK: - Edit Account
//extension CoreDataManager {
//    func edit(account: CDAccountModel, newName: String, newTimestamp: Date) {
//        account.name = newName
////        account.timestamp = newTimestamp
//        saveContext()
//    }
//}
