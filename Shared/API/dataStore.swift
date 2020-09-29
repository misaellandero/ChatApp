//
//  dataStore.swift
//  ChatApp
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI
import Firebase


class DataStore : ObservableObject {
    @Published var menssages : [Messages] = []
    @Published var contacts : [Contacts] = []
    
    init() {
        getUserContacts()
    }
    
    let dataBase = Firestore.firestore()
    
    func getUserContacts(){
        dataBase.collection("user_contacts").addSnapshotListener{ (snap, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = snap else {return}
            
            data.documentChanges.forEach{ (doc) in
                if doc.type == .added {
                    let contact = try! doc.document.data(as: Contacts.self)!
                    DispatchQueue.main.async {
                        self.contacts.append(contact)
                    }
                }
            }
            
        }
    }
}
