//
//  ChatMessageModel.swift
//  Oscar
//
//  Created by SWEET HOME (^0^)!!! on 20/11/2023.
//

import Foundation
import SwiftUI

enum MessageOwner {
    case user
    case bot
}

struct ChatMessageModel:Identifiable{
    var id = UUID().uuidString
    var owner:MessageOwner
    var text:String
    init(owner: MessageOwner = .user, text: String) {
        self.owner = owner
        self.text = text
    }
}
