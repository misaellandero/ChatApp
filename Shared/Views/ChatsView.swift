//
//  ChatView.swift
//  ChatApp
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI

struct ChatsView: View {
    var body: some View {
        NavigationView{
            List{
                MessageView(sender: false, text: "hi", date: Date(), user: "M")
                
                MessageView(sender: true, text: "hello", date: Date(), user: "J")
                
                MessageView(sender: false, text: "hi", date: Date(), user: "M")
                
                MessageView(sender: true, text: "hello", date: Date(), user: "J")
            }.listStyle(InsetGroupedListStyle())
        }
    }
}

struct MessageView: View {
    
    @State var sender : Bool
    @State var text : String
    @State var date : Date
    @State var user : String
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
                
                if !sender{
                    Image(systemName: "\(user).circle.fill")
                        .foregroundColor(.secondary)
                }
                
                Text("Hello world")
                            .padding(10)
                            .foregroundColor(sender ? Color.white : Color.primary)
                            .background(sender ? Color.blue : Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(20, corners: sender ? [.bottomLeft ,.topLeft,.topRight] : [.bottomRight,.topLeft,.topRight])
                
                if sender{
                    Image(systemName: "\(user).circle.fill")
                        .foregroundColor(.secondary)
                }
                
                if !sender{
                    Spacer()
                }
                
            }
            .listRowBackground(Color(colorScheme == .light ? UIColor.secondarySystemBackground : UIColor.systemBackground )
            .opacity(0.95))
            
        }
        
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MessageView(sender: false, text: "hi", date: Date(), user: "j")
            
            MessageView(sender: true, text: "hello", date: Date(), user: "m")
        }
        
       
    }
}
