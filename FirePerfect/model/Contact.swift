//
//  Contact.swift
//  FirePerfect
//
//  Created by MacBook Pro on 01/09/21.
//

import Foundation
struct Contact: Hashable {
    var firstname: String?
    var lastname: String?
    var phonenum: String?
    var imgUrl: String?
    init(firstname: String?, lastname: String?, phonenum: String? ) {
        self.firstname = firstname
        self.lastname = lastname
        self.phonenum = phonenum
    }
    init(firstname: String?, lastname: String?, phonenum: String? , imgUrl: String?) {
        self.firstname = firstname
        self.lastname = lastname
        self.phonenum = phonenum
        self.imgUrl = imgUrl
    }
}
