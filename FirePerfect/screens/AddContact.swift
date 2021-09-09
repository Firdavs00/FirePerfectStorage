

import SwiftUI

struct AddContact: View {
    @ObservedObject var database = RealtimeStore()
    @ObservedObject var storage = StorageStore()
    @Environment (\.presentationMode) var presentation
    @State var firstame = ""
    @State var lastname = ""
    @State var phonenum = ""
    @State var isloading = false
    @State var defImage = UIImage(imageLiteralResourceName: "ic_picker")
    @State var pickerImage: UIImage? = nil
    @State var showImagePicker: Bool = false
    func addNewContact(urlString: String){
        let contact = Contact(firstname: firstame, lastname: lastname, phonenum: phonenum,imgUrl: urlString)
        database.storePost(post: contact, completion: {seccess in
            isloading = false
            if seccess{
                self.presentation.wrappedValue.dismiss()
            }
        })
    }
    func upLoadImage()  {
        isloading = true
        storage.uploadImage(pickerImage!, completion: {downloadUrl in
            let urlString = downloadUrl!.absoluteString
            print(urlString)
            addNewContact(urlString: urlString)
            
        })
    }
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Button(action: {
                        self.showImagePicker.toggle()
                    }, label: {
                        Image(uiImage: pickerImage ?? defImage).resizable()
                            .frame(width: 100, height: 100).scaledToFit()
                    }).sheet(isPresented: $showImagePicker, onDismiss: {
                        self.showImagePicker = false
                    }, content: {
                        ImagePicker(image: self.$pickerImage, isShown: self.$showImagePicker)
                    })
                    
                    TextField("Firstname", text: $firstame).padding(.leading,10)
                        .frame(height:50).background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    TextField("Lastname", text: $lastname).padding(.leading,10)
                        .frame(height:50).background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    TextField("Phonenumber", text: $phonenum).padding(.leading,10)
                        .frame(height:50).background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    Button(action: {
//                        addNewContact()
                        upLoadImage()
                    }, label: {
                        Spacer()
                        Text("Add").foregroundColor(.white)
                        Spacer()
                    }).frame(height: 40).background(Color.red).cornerRadius(8)
                    Spacer()
                    
                }.padding()
                if isloading{
                    ProgressView()
                }
            }
            .navigationBarTitle("Add Contact", displayMode: .inline)
            .navigationBarItems(leading:
                                    
                                    Button(action: {
                                        self.presentation.wrappedValue.dismiss()
                                    }, label: {
                                        Text("exit").foregroundColor(.red)
                                    })
            )
        }
    }
}

struct AddContact_Previews: PreviewProvider {
    static var previews: some View {
        AddContact()
    }
}
