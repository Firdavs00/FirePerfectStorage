//
//  SignUpScreen.swift
//  FirePerfect
//
//  Created by MacBook Pro on 30/08/21.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.presentationMode) var presentation
    @State var fullname = ""
    @State var email = ""
    @State var password = ""
    @State var isLoading = false
    func doSignUp(){
        isLoading = true
        SessionStore().signUp(email: email, password: password, handler: {(res, err) in
            isLoading = false
            if err != nil{
                print("USer not created")
                return
            }
            print("USer created")
            self.presentation.wrappedValue.dismiss()
        })
    }
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Text("Create your accaunt").font(.system(size: 30)).foregroundColor(.red)
                TextField("Fullname", text: $fullname)
                    .frame(height:45).padding(.leading,10)
                    .background(Color.gray.opacity(0.2)).cornerRadius(20)
                TextField("Email", text: $email)
                    .frame(height:45).padding(.leading,10)
                    .background(Color.gray.opacity(0.2)).cornerRadius(20)
                SecureField("Password", text: $password)
                    .frame(height:45).padding(.leading,10)
                    .background(Color.gray.opacity(0.2)).cornerRadius(20)
                Button(action: {
                    doSignUp()
                }, label: {
                    Spacer()
                    Text("Sign Up").foregroundColor(.white)
                    Spacer()
                }).frame(height: 45).background(Color.red).cornerRadius(20)
                Spacer()
                VStack{
                    Spacer()
                    HStack{
                        Text("Alredy have an accaunt?")
                        Button(action: {
                            self.presentation.wrappedValue.dismiss()
                        }, label: {
                            Text("SignUp").foregroundColor(.red)
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

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
