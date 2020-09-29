//
//  ContactsView.swift
//  ChatApp
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI

struct ContactsView: View {
    @EnvironmentObject var session : SessionStore
    @EnvironmentObject var data : DataStore
    
    var body: some View {
        NavigationView{
            List{
                ForEach(data.contacts){ contac in
                    
                    NavigationLink(
                        destination: ContactDetailView(contac: contac)){
                        ContactView(contac: contac)
                    }
                    
                }
            }
            .navigationTitle("Contacts")
        }
    }
}

struct ContactDetailView : View {
    
    @State var contac: Contacts
    
    var body: some View{
        List{
            Section(header: Text("Name")) {
                HStack{
                    Text(contac.firstName)
                    Text(contac.lastName)
                }
                .font(.largeTitle)
            }
            
            Section(header: Text("Contact Info")) {
                HStack{
                    Text(contac.email)
                }
                HStack{
                    Text(contac.contactNumber)
                }
                HStack{
                    Spacer()
                    Button(action:{}){
                        Image(systemName: "phone.fill")
                    }
                    .padding()
                    .background(Color.green)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    Spacer()
                    Button(action:{}){
                        Image(systemName: "message.fill")
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    Spacer()
                }
            }
            
           
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(contac.firstName, displayMode: .inline)
        
    }
}

struct ContactView : View {
    @State var contac: Contacts
    var body: some View{
        HStack{
            Text(contac.firstName)
            Text(contac.lastName)
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
