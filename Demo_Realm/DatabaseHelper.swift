
import UIKit
import RealmSwift

class DatabaseHelper {
    
    static let shared = DatabaseHelper()
    
    private var realm = try! Realm()
    
    func getDatabaseURL() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL //The path of the database will know where the database store.
    }
    
    func saveContact(contact: Contact) {
        
        try! realm.write{
            realm.add(contact)
        }
        
    }
    
    func getAllContacts() -> [Contact]
    {
        //convert realm object to swift Array
        return Array(realm.objects(Contact.self)) //objects means get data into database.
    }
    
    func getSpecificContacts(_ name: String) -> [Contact]
    {
        //convert realm object to swift Array
        let arr = Array(realm.objects(Contact.self)) //objects meaning get data into database.
        var arr1 = [Contact]()
        
        for user in arr {
            
            if user.firstname == name {
                arr1.append(user)
            }
            
        }
        
        return arr1
    }
    
    func deleteContact(contact: Contact) {
        
        try! realm.write{
            realm.delete(contact)
        }
        
    }
    
    func updateContact(oldContact: Contact, newContact: Contact) {
        
        try! realm.write{
            
            oldContact.firstname = newContact.firstname
            oldContact.lastname = newContact.lastname
            
        }
        
    }
    
}

