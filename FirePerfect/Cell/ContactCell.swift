//
//  ContactCell.swift
//  FirePerfect
//
//  Created by MacBook Pro on 01/09/21.
//

import SwiftUI
import SDWebImageSwiftUI
struct ContactCell: View {
    var contact: Contact
    var body: some View {
        VStack(alignment: .leading){
            HStack{
             
            if contact.imgUrl != nil{
                WebImage(url: URL(string: contact.imgUrl!)).resizable()
                    .frame(width: 100, height: 100).scaledToFit()
            }else{
                Image("ic_picker").resizable()
                    .frame(width: 100, height: 100).scaledToFit()
            }
            
                VStack(alignment: .leading){
                HStack{
                    Text(contact.firstname!).font(.system(size: 20))
                        .fontWeight(.bold).foregroundColor(.red)
                    Text(contact.lastname!).font(.system(size: 20))
                        .fontWeight(.bold).foregroundColor(.red)
               
                }
                Text(contact.phonenum!).padding(.top, 5)
                }.padding()
            }
            
        }.padding().padding(.top,-10).padding(.bottom,-10)
    }
}

struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactCell(contact: Contact(firstname: "firstname", lastname: "lastname", phonenum: "phonenum"))
    }
}
