//
//  SignInScreen.swift
//  FirePerfect
//
//  Created by MacBook Pro on 30/08/21.
//

import SwiftUI

struct SignInScreen: View {
    @EnvironmentObject var session: SessionStore
    @State var showPresent = false
    @State var email = ""
    @State var password = ""
    @State var isLoading = false
    func doSignIn() {
        isLoading = true
        SessionStore().signIn(email: email, password: password, handler: {(res, err) in
            isLoading = false
            if err != nil{
                print("Check email or password")
                return
            }
            print("User signed In ")
            session.listen()
        })
    }
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Text("Welcome Back").foregroundColor(.red).font(.system(size: 30))
                TextField("Email", text: $email).frame(height:45).padding(.leading,10)
                    .background(Color.gray.opacity(0.2)).cornerRadius(20)
                SecureField("Password", text: $password).frame(height:45).padding(.leading,10)
                    .background(Color.gray.opacity(0.2)).cornerRadius(20)
                Button(action: {
                    doSignIn()
                }, label: {
                    Spacer()
                    Text("Sign In").foregroundColor(.white)
                    Spacer()
                }).frame(height: 45).background(Color.red).cornerRadius(20)
                Spacer()
                VStack{
                    Spacer()
                    HStack{
                        Text("Don't have an accaunt?")
                        Button(action: {
                            showPresent.toggle()
                        }, label: {
                            Text("SignUp").foregroundColor(.red)
                        }).sheet(isPresented: $showPresent, content: {
                            SignUpScreen()
                        })
                    }
                }.frame(maxWidth: .infinity, maxHeight: 200)
            }.padding()
            if isLoading{
                ProgressView()
            }
        }
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
