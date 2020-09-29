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
    
    @State var showAddContact = false
    
    var body: some View {
        NavigationView{
                    List{
                        
                        ForEach(data.contacts, id: \.self){ contac in
                            if contac.uidOwner == session.user?.uid {
                                NavigationLink(
                                    destination: ContactDetailView(contac: contac)){
                                    ContactView(contac: contac)
                                }
                            } 
                        }
                        
                    }
                    .navigationTitle("Contacts")
                    
            .navigationBarItems(trailing:
                                    HStack{
                                        Button(action: {
                                        showAddContact.toggle()
                                        }){
                                            Image(systemName: "person.crop.circle.fill.badge.plus")
                                        }
                                        
                                        Button(action: {
                                            data.reloadData()
                                        }){
                                            Image(systemName: "arrow.counterclockwise.circle.fill")
                                        }
                                    }
                                    )
        }
        .sheet(isPresented:$showAddContact){
            NewContactView()
        }
    }
}

struct NewContactView : View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var contactNumber = ""
    @State var uidOwner = ""
    
    @EnvironmentObject var session : SessionStore
    @EnvironmentObject var data : DataStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        NavigationView{
            ScrollView {
                VStack(spacing: 20){
                    
                    circleColorIconSystem(name: "person.crop.circle.fill.badge.plus")
                        .padding()
                        .frame(width: 250)
                    
                    HStack{
                        Image(systemName: "person.2")
                        TextField("firstName", text: $firstName)
                        TextField("lastName", text: $lastName)
                    }
                    .padding(12)
                    .frame(minWidth:0, maxWidth: 400)
                    .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                    .foregroundColor(.blue)
                    
                    HStack{
                        Image(systemName: "envelope.circle.fill")
                         TextField("email", text: $email)
                         .autocapitalization(.none)
                    }
                    .padding(12)
                    .frame(minWidth:0, maxWidth: 400)
                    .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                    .foregroundColor(.blue)
                    
                    HStack{
                        Image(systemName: "phone.fill")
                        TextField("contactNumber", text: $contactNumber)
                    }
                    .padding(12)
                    .frame(minWidth:0, maxWidth: 400)
                    .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                    .foregroundColor(.blue)
                    
                    Button(action: {
                        data.addContact(firstName: firstName, lastName: lastName, email: email, contactNumber: contactNumber, uidOwner: session.user!.uid)
                        presentationMode.wrappedValue.dismiss()
                        
                    }){
                       PrymaryButton(text: "Save", icon: "plus.circle")
                    }
                    
                    Button(action: {
                        
                            presentationMode.wrappedValue.dismiss()
                        
                    }){
                        CancelButton(text: "Cancel", icon: "xmark.circle.fill")
                    }
                    
                }
                .frame(minWidth:0, maxWidth: 300)
                .padding()
                Spacer()
            }
            .navigationBarTitle("New Contact", displayMode: .inline)
            
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
                
            }
            
           
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(contac.firstName, displayMode: .inline)
        .navigationBarItems(trailing:
            HStack{
                Button(action:{}){
                    Image(systemName: "phone.fill")
                }
                .accentColor(.green)
               
                Button(action:{}){
                    Image(systemName: "message.fill")
                }
                .accentColor(.blue)
        })
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
