//
//  ChatGPT_ViewModel.swift
//  Oscar
//
//  Created by SWEET HOME (^0^)!!! on 20/11/2023.
//

import Foundation
import SwiftUI
import ChatGPTSwift

@MainActor
class ChatGPT_ViewModel:ObservableObject{
    let api = ChatGPTAPI(apiKey: "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")
  
    @Published var arr_chatMessages = [ChatMessageModel]()
    @Published var isWaitingForResponse = false
    
    func sendMessage(messageString:String) async throws {
        let userMessage = ChatMessageModel(text: messageString)
        self.arr_chatMessages.append(userMessage)
        
        isWaitingForResponse = true
        //fecth gpt
        print("ask string: ", messageString)
        let botMessage = ChatMessageModel(owner: MessageOwner.bot,text: "")
        self.arr_chatMessages.append(botMessage)
        
        let stream = try await api.sendMessageStream(text: messageString)
       
        for try await line in stream{
            if let lastMessage =  self.arr_chatMessages.last {
                let text = lastMessage.text
                print(text)
                print(line)
                let newMessage = ChatMessageModel(owner: MessageOwner.bot,text: text + line)
                self.arr_chatMessages[self.arr_chatMessages.count - 1] = newMessage
            }
        }
        
        isWaitingForResponse = false
    }
    
    
    
}
