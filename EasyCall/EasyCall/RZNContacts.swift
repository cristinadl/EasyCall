//
//  RZNContacts.swift
//  RZNContacts
//  This class is made for storing basis informaiton in to contacts of iOS.
//  Created by virtualrizwan on 12/09/18.
//  Copyright © 2018 virtualrizwan. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Contacts

enum ContactType : Int {
    case person
    case organization
}

struct ContactDetails {
 

    var typeOfContact: ContactType?

    var givenName:  String
    var middelName: String?
    var familyName: String?
    
    var birthday: DateComponents?
    
    var organizationName: String?
    var departmentName: String?
    var jobTitle: String?

    var note: String?
    
    var numbers: [String:String]?                        //[CNLabeledValue<CNPhoneNumber>]
    var emails: [String:String]?                         //[CNLabeledValue<NSString>]
    var urlAddresses: [String:String]?                   //[CNLabeledValue<NSString>]
    
    var profileImage: Data?

    init(givenName: String) {
        self.givenName = givenName
    }
}

public enum ContactOperationResult {
    case Success(response: Bool)
    case Error(error: Error)
}

public enum ContactsFetchResult {
    case Success(response: [CNContact])
    case Error(error: Error)
}

class RZNContacts: NSObject {

    class func contactsAccessAuthorized() -> Bool {
        CNContactStore().requestAccess(for: .contacts, completionHandler: {(success,error) in if success {
            print(" ")
            }})
        let status = CNContactStore.authorizationStatus(for: .contacts)
        if status == .restricted || status == .denied || status == .notDetermined{
            print("Contacts Acess Denied")
            return false;
        } else {
            print("Contacts Acess Granted")
            return true;
        }
    }

    class func addContact(_ contact: ContactDetails) {
        if (!contactsAccessAuthorized()) {
            // alert here to seek access in settings and return
            return
        }
            
        let store = CNContactStore()
        let contactToAdd = CNMutableContact()
        
        //if let gName = contact.givenName {
            contactToAdd.givenName = contact.givenName
        //}
        
        if let mName = contact.middelName {
            contactToAdd.middleName = mName
        }
        
        if let fName = contact.familyName {
            contactToAdd.familyName = fName
        }
        
        if let contactNumbers = contact.numbers {
            var phoneNumbers = [CNLabeledValue<CNPhoneNumber>]()
            for (typeLabel, number) in contactNumbers {
                let number = CNPhoneNumber(stringValue: number)
                let labeledNumber = CNLabeledValue(label: typeLabel, value: number)
                phoneNumbers.append(labeledNumber)
            }
            contactToAdd.phoneNumbers = phoneNumbers
        }
        
        if let contactEmails = contact.emails {
            var emails = [CNLabeledValue<NSString>]()
            for (typeLabel, email) in contactEmails {
                let labeledEmail = CNLabeledValue(label: typeLabel, value: email as NSString)
                emails.append(labeledEmail)
            }
            contactToAdd.emailAddresses = emails
        }
        
        if let contactUrls = contact.urlAddresses {
            var urls = [CNLabeledValue<NSString>]()
            for (typeLabel, url) in contactUrls {
                let labeledUrl = CNLabeledValue(label: typeLabel, value: url as NSString)
                urls.append(labeledUrl)
            }
            contactToAdd.urlAddresses = urls
        }
        
        if let notes = contact.note {
            contactToAdd.note = notes
        }
        
        if let jTitle = contact.jobTitle {
            contactToAdd.jobTitle = jTitle
        }
        
        if let organization = contact.organizationName {
            contactToAdd.organizationName = organization
        }

        if let image = contact.profileImage {
            contactToAdd.imageData = image
        }
        
        let saveRequest = CNSaveRequest()
        saveRequest.add(contactToAdd, toContainerWithIdentifier: nil)
        
        do {
            try store.execute(saveRequest)
        } catch {
            print(error)
        }
    }
    
    

    
// Update Contact
/// Updates an existing contact in the contact store.
/// - parameter mutContact: A mutable value object for the contact properties, such as the first name and the phone number of a contact.
/// - parameter completionHandler: Returns Either CNContact or Error.
    class func updateContact(Contact mutContact: CNMutableContact, completionHandler: @escaping (_ result: ContactOperationResult) -> ()) {
        let store: CNContactStore = CNContactStore()
        let request: CNSaveRequest = CNSaveRequest()
        request.update(mutContact)
        do {
            try store.execute(request)
            completionHandler(ContactOperationResult.Success(response: true))
        } catch {
            completionHandler(ContactOperationResult.Error(error: error))
        }
    }
    
// Delete Contact
/// Deletes a contact from the contact store.
/// - parameter mutContact: A mutable value object for the contact properties, such as the first name and the phone number of a contact.
/// - parameter completionHandler: Returns Either CNContact or Error.
    class func deleteContact(Contact mutContact: CNMutableContact, completionHandler: @escaping (_ result: ContactOperationResult) -> ()) {
        let store: CNContactStore = CNContactStore()
        let request: CNSaveRequest = CNSaveRequest()
        request.delete(mutContact)
        do {
            try store.execute(request)
            completionHandler(ContactOperationResult.Success(response: true))
        } catch {
            completionHandler(ContactOperationResult.Error(error: error))
        }
    }
    
    @available(iOS 10.0, *)
    class func fetchContacts(ContactsSortorder sortOrder: CNContactSortOrder = .givenName, completionHandler: @escaping (_ result: ContactsFetchResult) -> ()) {
        
        let contactStore: CNContactStore = CNContactStore()
        var contacts: [CNContact] = [CNContact]()
        let fetchRequest: CNContactFetchRequest = CNContactFetchRequest(keysToFetch: [CNContactVCardSerialization.descriptorForRequiredKeys()])
        fetchRequest.unifyResults = true
        fetchRequest.sortOrder = sortOrder
        do {
            try contactStore.enumerateContacts(with: fetchRequest, usingBlock: {
                contact, _ in
                contacts.append(contact) })
            completionHandler(ContactsFetchResult.Success(response: contacts))
        } catch {
            completionHandler(ContactsFetchResult.Error(error: error))
        }
    }
}
