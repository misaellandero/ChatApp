//
//  HomeView.swift
//  ChatApp
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var session : SessionStore
    @State private var selection = 0
    
    private var NavigationBartitles = ["Home", "Contacts", "Profile"]
    
    func getUser(){
        session.listen()
    }
    
    var body: some View {
        NavigationView{
            TabView(selection: $selection){
                Text("Hi \(session.session?.email ?? "No email")!")
                .tabItem {
                        VStack {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    }
                    .tag(0)
                
                Text("Second View")
                    .font(.title)
                     
                    .tabItem {
                        VStack {
                            Image(systemName: "person.2")
                            Text("Contacts")
                        }
                    }
                    .tag(1)
                UserSettingsView(session: self.session)
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "person.crop.circle")
                            Text("Profile")
                        }
                }
                .tag(2)
            }
            .navigationBarTitle(NavigationBartitles[selection])
            .navigationBarItems( trailing: HStack {
                NavigationLink(destination: UserSettingsView(session: self.session).environmentObject(SessionStore()) ) {
                               Image(systemName: "gear")
                           }
                
            }.font(.headline))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
