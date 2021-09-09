//
//  HomeScreen.swift
//  FirePerfect
//
//  Created by MacBook Pro on 30/08/21.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var database = RealtimeStore()
    @EnvironmentObject var session: SessionStore
    @State var showPresent = false
    @State var isLoading = false
    func doSignOut(){
        isLoading = true
        if  SessionStore().signOut(){
            isLoading = false
            session.listen()
        }
    }
    func apiContacts(){
        database.loadPosts {
            print(database.items.count)
        }
    }
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(database.items, id:\.self){ item in
                        ContactCell(contact: item)
                        
                    }
                        
                }.listStyle(PlainListStyle())
                if isLoading{
                        ProgressView()
                    }
                }
            .navigationBarItems(trailing:
                                    HStack{
                                        Button(action: {
                                            showPresent.toggle()
                                        }, label: {
                                            Image("ic_add")
                                        }).sheet(isPresented: $showPresent, content: {
                                            AddContact()
                                        })
                                        Button(action: {
                                            doSignOut()
                                        }, label: {
                                            Image("ic_exit")
                                        })
                                    }
            )
            .navigationBarTitle("Contacts", displayMode: .inline)
        }.onAppear{
            apiContacts()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
