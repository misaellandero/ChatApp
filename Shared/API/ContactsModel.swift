//
//  ContactsModel.swift
//  ChatApp
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Contacts : Codable, Identifiable, Hashable {
    
    @DocumentID var id : String?
    
    var firstName: String
    var lastName: String
    var email: String
    var contactNumber : String
    var uidOwner : String
    
    enum CodingKeys: String , CodingKey {
        case firstName
        case lastName
        case email
        case contactNumber
        case uidOwner
    }
    
}



 
