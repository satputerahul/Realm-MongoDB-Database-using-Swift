
// Created by Rahul

import UIKit
import RealmSwift

class Contact: Object {
    
    @Persisted var firstname: String
    @Persisted var lastname: String
    
      convenience init(firstname: String, lastname: String) {
            self.init()
            self.firstname = firstname
            self.lastname = lastname
        }
    
}

class ViewController: UIViewController {
    
    @IBOutlet var tv_contact: UITableView!
    
    var contactArray = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configuration(tv_contact)
        
        // tv_contact.delegate = self
        // tv_contact.dataSource = self
        
    }
    
    @IBAction func AddContactButtonTapped(_ sender: UIBarButtonItem) {
        
        contactConfiguration(isAdd: true, index: 0, table: tv_contact)
        
    }
    
}

extension ViewController
{
    func configuration(_ table: UITableView){
         contactArray = DatabaseHelper.shared.getAllContacts()
        
       // contactArray = DatabaseHelper.shared.getSpecificContacts("iOS")
        print("Data:", contactArray)
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func contactConfiguration(isAdd: Bool, index: Int, table: UITableView)
    {
        
        let alertController = UIAlertController(title: isAdd ? "Add Contact" : "Update Contact", message: isAdd ? "Please enter your contact details" : "Please update your contact details" , preferredStyle: .alert)
        
        let save = UIAlertAction(title: isAdd ? "Save" : "Update", style: .default) { _ in
            if let firstname = alertController.textFields?[0].text,
        
               let lastname = alertController.textFields?[1].text {
                
                let contact = Contact(firstname: firstname, lastname: lastname)
                
                if isAdd {
                    //if true then Add
                    self.contactArray.append(contact)
                    DatabaseHelper.shared.saveContact(contact: contact)
                } else {
                    //else Update
                    DatabaseHelper.shared.updateContact(oldContact: self.contactArray[index], newContact: contact)
                   // self.contactArray[index] = contact
                }
                table.reloadData()
                
                print("Data:", self.contactArray)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField { firstnameField in
            
            firstnameField.placeholder = isAdd ? "Enter your firstname" : self.contactArray[index].firstname
        }
        
        alertController.addTextField { lastnameField in
            
            lastnameField.placeholder = isAdd ? "Enter your lastname" : self.contactArray[index].lastname
            
        }
        
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
        
    }
}

extension ViewController: UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = contactArray[indexPath.row].firstname
        cell.detailTextLabel?.text = contactArray[indexPath.row].lastname
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    @available(iOS 15.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
            
            self.contactConfiguration(isAdd: false, index: indexPath.row, table: tableView)
            
        }
        edit.backgroundColor = .systemMint
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            
//            let firstName = self.contactArray[indexPath.row].firstname
//            let lastName = self.contactArray[indexPath.row].lastname
//
//            
//            let contact = Contact(firstname: firstName, lastname: lastName)
           
            print(self.contactArray[indexPath.row])
            DatabaseHelper.shared.deleteContact(contact: self.contactArray[indexPath.row])
            self.contactArray.remove(at: indexPath.row)
            
            tableView.reloadData()
            
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipeConfiguration
    }
    
}


///ADD

/*
 let alertController = UIAlertController(title: "Add Contact", message: "Please enter your contact details", preferredStyle: .alert)
 
 let save = UIAlertAction(title: "Save", style: .default) { _ in
 if let firstname = alertController.textFields?[0].text,
 //   let middlename = alertController.textFields?[1].text,
 let lastname = alertController.textFields?[1].text {
 
 let contact = Contact(firstname: firstname, lastname: lastname)
 self.contactArray1.append(contact)
 self.tv_contact.reloadData()
 
 print(firstname, lastname)
 }
 }
 let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
 
 alertController.addTextField { firstnameField in
 firstnameField.placeholder = "Enter your firstname"
 
 }
 
 //        alertController.addTextField { middlenameField in
 //            middlenameField.placeholder = "Enter your middlename"
 //
 //        }
 
 alertController.addTextField { lastnameField in
 lastnameField.placeholder = "Enter your lastname"
 
 }
 
 alertController.addAction(save)
 alertController.addAction(cancel)
 
 present(alertController, animated: true)
 */

///UPDATE
/*
 let alertController = UIAlertController(title: "Update Contact", message: "Please Update your contact details", preferredStyle: .alert)
 
 let save = UIAlertAction(title: "Save", style: .default) { _ in
 if let firstname = alertController.textFields?[0].text,
 //   let middlename = alertController.textFields?[1].text,
 let lastname = alertController.textFields?[1].text {
 
 let contact = Contact(firstname: firstname, lastname: lastname)
 // self.contactArray1.append(contact)
 self.contactArray1[indexPath.row] = contact //Update
 self.tv_contact.reloadData()
 
 print(firstname, lastname)
 }
 }
 let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
 
 alertController.addTextField { firstnameField in
 firstnameField.placeholder = self.contactArray1[indexPath.row].firstname
 
 }
 
 //        alertController.addTextField { middlenameField in
 //            middlenameField.placeholder = "Enter your middlename"
 //
 //        }
 
 alertController.addTextField { lastnameField in
 lastnameField.placeholder = self.contactArray1[indexPath.row].lastname
 
 }
 
 alertController.addAction(save)
 alertController.addAction(cancel)
 
 self.present(alertController, animated: true)
 */

//            if isAdd {
//                firstnameField.placeholder = "Enter your firstname"
//            } else {
//                firstnameField.placeholder = self.contactArray[index].firstname
//            }

//            if isAdd {
//                lastnameField.placeholder = "Enter your lastname"
//            } else {
//                lastnameField.placeholder = self.contactArray[index].lastname
//            }
