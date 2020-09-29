//
//  ChatView.swift
//  ChatApp
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI

struct ChatsView: View {
    @EnvironmentObject var session : SessionStore
    @EnvironmentObject var data : DataStore
    
    @State var messages : [Messages]
    
    @State var contact : Contacts
    @State var message = ""
    
    @State var sender : String
    @State var reciber : String
  
    var chats : [Messages] {
        var chatMessages = [Messages]()
        
        for message in data.menssages {
            
            print("este mensaje lo mando \(message.uidOwner) y era para \(message.emailAdress)")
            
            if (message.uidOwner == sender && message.emailAdress == reciber) || (message.emailAdress == sender && message.uidOwner == reciber) {
                print("este mensaje es de esta conversacion")
                chatMessages.append(message)
            } else {
                print("este mensaje NO ES DE ESTA conversacion")
            }
        }
        
        chatMessages.sort {
            $0.date < $1.date
        }
        
        print(chatMessages)
        
        return chatMessages
    }
    
    var body: some View {
        NavigationView{
                
                VStack{
                    //Messages list
                    List{
                        
                        ForEach(self.chats, id: \.self){ message in
                            
                            if message.uidOwner == sender {
                                MessageView(sender: true, text: message.messages,date: message.date)
                            } else {
                                MessageView(sender: false, text: message.messages,date: message.date)
                            }
                            
                        }
                      
                    }.listStyle(InsetGroupedListStyle())
                    
                    //User input Area
                    HStack{
                        Image(systemName: "message.fill")
                        TextField("New Message", text: $message)
                        
                        if message != "" {
                            Button(action: {
                                self.sendMessage()
                            }){
                                circleColorIconSystem(name:  "paperplane.fill")
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                    .padding(12)
                    .frame(minWidth:0, maxWidth: 400)
                    .frame(minHeight: CGFloat(50))
                    .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                    .foregroundColor(.blue)
                    
                    .navigationBarTitle(contact.firstName, displayMode: .inline)
                    
                }
            
            
        }
    }
    
    func getChats() -> [Messages] {
        
        var chatMessages = [Messages]()
        
        for message in messages {
            
            print("este mensaje lo mando \(message.uidOwner) y era para \(message.emailAdress)")
            
            if (message.uidOwner == sender && message.emailAdress == reciber) || (message.emailAdress == sender && message.uidOwner == reciber) {
                print("este mensaje es de esta conversacion")
                chatMessages.append(message)
            } else {
                print("este mensaje NO ES DE ESTA conversacion")
            }
        }
        
        chatMessages.sort {
            $0.date < $1.date
        }
        
        print(chatMessages)
        
        return chatMessages
    }
    
    func sendMessage(){
        let message = self.message
        let id = session.user?.email ?? "no mail"
        let email = contact.email
        data.sendMessage(messages: message, uidOwner: id, emailAdress: email)
        self.message = ""
    }
}

struct MessageView: View {
    
    @State var sender : Bool
    @State var text : String
    @State var date : Date
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var formatedDate: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let dateString = formatter.string(from: self.date)
        return dateString
    }
    
    var body: some View {
        Section(header: HStack{
            if sender{
                Spacer()
            }
            Text(formatedDate)
                .foregroundColor(.secondary)
                .font(.caption)
            if !sender{
                Spacer()
            }
             
        }){
            HStack(){
                
                if sender{
                    Spacer()
                }
                 
                Text("\(text)")
                            .padding(10)
                            .foregroundColor(sender ? Color.white : Color.primary)
                            .background(sender ? Color.blue : Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(20, corners: sender ? [.bottomLeft ,.topLeft,.topRight] : [.bottomRight,.topLeft,.topRight])
                
                
                if !sender{
                    Spacer()
                }
                
            }
            .listRowBackground(Color(colorScheme == .light ? UIColor.secondarySystemBackground : UIColor.systemBackground )
            .opacity(0.95))
            
        }
        
    }
}


