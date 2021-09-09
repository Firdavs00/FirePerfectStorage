//
//  StarterView.swift
//  FirePerfect
//
//  Created by MacBook Pro on 30/08/21.
//

import SwiftUI
struct StarterView: View {
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
//   Bu shart 1-HomeScreen ga boremi yoki SignInScreen ga manosini anglatadi
        VStack{
            if session.session != nil{
                HomeScreen()
            }else{
                SignInScreen()
            }
            
        }.onAppear{
            session.listen()
        }
    }
}

struct StarterView_Previews: PreviewProvider {
    static var previews: some View {
        StarterView()
    }
}
