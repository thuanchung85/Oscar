//
//  UIView.swift
//  Oscar
//
//  Created by SWEET HOME (^0^)!!! on 16/11/2023.
//

import Foundation
import SwiftUI



struct TopLayer_UI_View: View {
    
    @EnvironmentObject private var env: ENVOBJECT
    var nameOf3dModel :String
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    @StateObject private var chatGPT_viewModel = ChatGPT_ViewModel()
    
    @State var  isCatTalk = false
    @State var  isUserTalk = true
    @State var isInChatMode = false
    
    @State var chatBotString = ""
    
   //====BODY===///
    var body: some View {
       
            ZStack{
                
               
                Layer2()
                    .environmentObject(OrientationInfo())
                
                Layer3(nameOf3dModel:nameOf3dModel)
                    .environmentObject(OrientationInfo())
                
                //khi không chat với nhau
                if(isInChatMode == false)
                {
                    Layer1( isInChatMode: $isInChatMode)
                        .environmentObject(OrientationInfo())
                }
                //khi chat với nhau
                if(isInChatMode == true)
                {
                    if(isCatTalk == true) && (isUserTalk == false){
                        layer5(isCatTalk: $isCatTalk, isUserTalk: $isUserTalk,
                               isInChatMode: $isInChatMode,
                               chatBotString: chatBotString)
                            .environmentObject(OrientationInfo())
                            
                    }
                    if(isCatTalk == false) && (isUserTalk == true){
                        layer4(isUserTalk:$isUserTalk,
                               speechRecognizerString:  "당신은 말한다: \n" + speechRecognizer.transcript,
                               isCatTalk: $isCatTalk, isInChatMode: $isInChatMode)
                            .environmentObject(OrientationInfo())
                            .onAppear(){
                                speechRecognizer.reset()
                                speechRecognizer.transcript = ""
                                speechRecognizer.transcribe()
                            }
                            .onDisappear(){
                                speechRecognizer.stopTranscribing()
                                //call gpt
                                Task{
                                    do{
                                        try await chatGPT_viewModel.sendMessage( messageString: speechRecognizer.transcript)
                                    }
                                    catch{
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                    }
                }
                
                
                
            }
            .environmentObject(env)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .onReceive(chatGPT_viewModel.$arr_chatMessages.throttle(for: 0.5, scheduler: RunLoop.main, latest: true)) { chatMessages in
                guard !chatMessages.isEmpty else {return}
               // print("chatMessages: ", chatMessages)
                self.chatBotString = chatMessages.last!.text
            }
           
    }
}



//layer chưa nút micro
struct Layer1:View{
    @EnvironmentObject var env: ENVOBJECT
    @EnvironmentObject var orientationInfo: OrientationInfo
    
    @Binding var isInChatMode:Bool
   
    
    //===BODY===//
    var body: some View {
        if(orientationInfo.orientation == .portrait){
            VStack(alignment: .center) { // explicit container with center default alignment
                Spacer()
                //====BUTTON MICRO====//
                HStack{
                    Button(action: {
                        //callSpeech()
                        
                    }) {
                        if #available(iOS 16.0, *) {
                            RoundedRectangle(cornerRadius: 50)
                                .frame(width: 100, height: 100)
                                .foregroundStyle(
                                    .linearGradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .shadow(.inner(color: .white.opacity(0.2), radius: 0, x: 1, y: 1))
                                    .shadow(.inner(color: .white.opacity(0.05), radius: 4, x: 0, y: -4))
                                    .shadow(.drop(color: .black.opacity(0.5), radius: 30, y: 30))
                                )
                                .overlay(RoundedRectangle(cornerRadius: 50).stroke(.white, lineWidth: 1))
                                .overlay(Image(systemName: "mic.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.white)
                                    .frame(width: 50, height: 50))
                        } else {
                            // Fallback on earlier versions
                        }
                    }//end button
                    .background(
                        ZStack {
                            AngularGradient(colors: [.red, .blue, .teal, .red], center: .center)
                                .cornerRadius(30)
                                .blur(radius: 15)
                            AngularGradient(colors: [.white, .blue, .teal, .white], center: .center)
                                .cornerRadius(30)
                                .blur(radius: 15)
                        }
                    )
                    .preferredColorScheme(.dark)
                    .onAppear {
                        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                           
                        }
                    }
                    .opacity(0.7)
                    .padding(.bottom,10)
                    .simultaneousGesture(
                            LongPressGesture()
                                .onEnded { _ in
                                    print("Loooong")
                                    //isRecording = true
                                }
                        )
                        .highPriorityGesture(
                            TapGesture()
                                .onEnded { _ in
                                    print("Tap")
                                    isInChatMode = true
                                    //isRecording = true
                                }
                        )
                }//end Hstack
                .padding(.bottom,10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        
        if(orientationInfo.orientation == .landscape){
            VStack(alignment: .center) { // explicit container with center default alignment
              
                //====BUTTON MICRO====//
                HStack{
                    Spacer()
                    Button(action: {
                        //callSpeech()
                    }) {
                        if #available(iOS 16.0, *) {
                            RoundedRectangle(cornerRadius: 50)
                                .frame(width: 100, height: 100)
                                .foregroundStyle(
                                    .linearGradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .shadow(.inner(color: .white.opacity(0.2), radius: 0, x: 1, y: 1))
                                    .shadow(.inner(color: .white.opacity(0.05), radius: 4, x: 0, y: -4))
                                    .shadow(.drop(color: .black.opacity(0.5), radius: 30, y: 30))
                                )
                                .overlay(RoundedRectangle(cornerRadius: 50).stroke(.white, lineWidth: 1))
                                .overlay(Image(systemName: "mic.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.white)
                                    .frame(width: 50, height: 50))
                        } else {
                            // Fallback on earlier versions
                        }
                    }//end button
                    .background(
                        ZStack {
                            AngularGradient(colors: [.red, .blue, .teal, .red], center: .center)
                                .cornerRadius(30)
                                .blur(radius: 15)
                            AngularGradient(colors: [.white, .blue, .teal, .white], center: .center)
                                .cornerRadius(30)
                                .blur(radius: 15)
                        }
                    )
                    .preferredColorScheme(.dark)
                    .onAppear {
                        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                          
                        }
                    }
                    .opacity(0.7)
                    .simultaneousGesture(
                            LongPressGesture()
                                .onEnded { _ in
                                    print("Loooong")
                                    //isRecording = true
                                }
                        )
                        .highPriorityGesture(
                            TapGesture()
                                .onEnded { _ in
                                    print("Tap")
                                    isInChatMode = true
                                }
                        )
                }//end Hstack
                .padding(10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
   
}


//layer chứa avatar
struct Layer2:View{
    @EnvironmentObject var orientationInfo: OrientationInfo
    //===BODY===//
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(alignment: .center){
                AvatarView(image: Image("avatar"), size: 50)
                    .padding(.leading,15)
                Spacer()
            }.frame(width: UIScreen.main.bounds.width, height: 50)
            .padding(.top,15)
            Spacer()
        }
        .frame(height:UIScreen.main.bounds.height)
    }
}



//layer chứa text tên
struct Layer3:View{
    @EnvironmentObject var orientationInfo: OrientationInfo
    
    var nameOf3dModel:String
    var body: some View {
        if(orientationInfo.orientation == .portrait){
            ZStack{
                VStack{
                    
                    //name of 3d character
                    HStack(alignment: .center){
                        
                        Text(nameOf3dModel)
                            .frame(width: 150, height: 50, alignment: .center)
                            .scaledToFit()
                            .minimumScaleFactor(0.5)
                            .font(.largeTitle)
                            .foregroundStyle(
                                .linearGradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                                //.shadow(.inner(color: .white.opacity(0.2), radius: 0, x: 1, y: 1))
                                //.shadow(.inner(color: .white.opacity(0.05), radius: 4, x: 0, y: -4))
                                //.shadow(.drop(color: .black.opacity(0.5), radius: 30, y: 30))
                            )
                            .padding(.horizontal,15)
                            .shadow(color: .blue, radius: 1)
                        
                        
                        
                    }
                    .frame(width: 200, height: 60, alignment: .center)
                    .background(.white.opacity(0.5))
                    .cornerRadius(30)
                    .padding(.top,10)
                    .padding(.trailing,10)
                    Spacer()
                    
                    
                    
                    
                }//end Vstack
                VStack{
                    Button(action: {
                        print("Circular Button tapped")
                    }) {
                        if #available(iOS 16.0, *) {
                            RoundedRectangle(cornerRadius: 50)
                                .frame(width: 50, height: 50)
                                .foregroundStyle(
                                    .linearGradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    
                                )
                                .overlay(RoundedRectangle(cornerRadius: 50).stroke(.white, lineWidth: 1))
                                .overlay(Text("50$"))
                        } else {
                            // Fallback on earlier versions
                        }
                    }//end button
                    .background(
                        ZStack {
                            AngularGradient(colors: [.red, .blue, .teal, .red], center: .center)
                                .cornerRadius(30)
                                .blur(radius: 15)
                            AngularGradient(colors: [.white, .blue, .teal, .white], center: .center)
                                .cornerRadius(30)
                                .blur(radius: 15)
                        }
                    )
                    .preferredColorScheme(.dark)
                    .onAppear {
                        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                            
                        }
                    }
                    .padding(.top,15)
                    .padding(.trailing,15)
                    .opacity(0.7)
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .topTrailing)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        }
        
        if(orientationInfo.orientation == .landscape){
            VStack{
                Spacer()
                HStack{
                    Text(nameOf3dModel)
                        .frame(width: 150, height: 50, alignment: .center)
                        .scaledToFit()
                        .minimumScaleFactor(0.5)
                        .font(.largeTitle)
                        .foregroundStyle(
                            .linearGradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                            //.shadow(.inner(color: .white.opacity(0.2), radius: 0, x: 1, y: 1))
                            //.shadow(.inner(color: .white.opacity(0.05), radius: 4, x: 0, y: -4))
                            //.shadow(.drop(color: .black.opacity(0.5), radius: 30, y: 30))
                        )
                        .padding(.horizontal,15)
                        .shadow(color: .blue, radius: 1)
                    
                    Button(action: {
                        print("Circular Button tapped")
                    }) {
                        if #available(iOS 16.0, *) {
                            RoundedRectangle(cornerRadius: 50)
                                .frame(width: 50, height: 50)
                                .foregroundStyle(
                                    .linearGradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    
                                )
                                .overlay(RoundedRectangle(cornerRadius: 50).stroke(.white, lineWidth: 1))
                                .overlay(Text("50$"))
                        } else {
                            // Fallback on earlier versions
                        }
                    }//end button
                    .background(
                        ZStack {
                            AngularGradient(colors: [.red, .blue, .teal, .red], center: .center)
                                .cornerRadius(30)
                                .blur(radius: 15)
                            AngularGradient(colors: [.white, .blue, .teal, .white], center: .center)
                                .cornerRadius(30)
                                .blur(radius: 15)
                        }
                    )
                    .preferredColorScheme(.dark)
                    .onAppear {
                        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                            
                        }
                    }
                    .opacity(0.7)
                }
                .frame(width: 250, height: 60, alignment: .center)
                .background(.white.opacity(0.5))
                .cornerRadius(30)
                .padding(.bottom,10)
                .padding(.leading,10)
                
                
            }//end Vstack
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .leading)
        }
    }
}


//layer chứa text nói của user
struct layer4:View{
    @EnvironmentObject var orientationInfo: OrientationInfo
    @Binding var isUserTalk:Bool
    var speechRecognizerString:String
    @Binding var isCatTalk:Bool
    @Binding var isInChatMode:Bool
    @State var scale = 0.1
    
    let dtxt = "Your secret API keys are listed below. Please note that we do not display your secret API keys again after you generate them. Do not share your API key with others, or expose it in the browser or other client-side code. In order to protect the security of your account, OpenAI may also automatically disable any API key that we've found has leaked publicly."
  
    
    //===BODY===//
    var body: some View {
        if(orientationInfo.orientation == .portrait){
            ZStack{
                VStack{
                    Spacer()
                    VStack{
                        ScrollView{
                            Text(speechRecognizerString)
                                .foregroundColor(.black)
                        }
                        .padding(10)
                    }
                    .frame(width: UIScreen.main.bounds.width - 20, height: 150, alignment: .leading)
                    .background(.white.opacity(0.8))
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.white).opacity(0.5), lineWidth: 1))
                    
                    .simultaneousGesture(
                            LongPressGesture()
                                .onEnded { _ in
                                    print("Cancel chat")
                                    isInChatMode = false
                                    isCatTalk = false
                                    isUserTalk = true
                                }
                        )
                        .highPriorityGesture(
                            TapGesture()
                                .onEnded { _ in
                                    print("Tap cat message")
                                    isCatTalk = true
                                    isUserTalk = false
                                }
                        )
                   
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .scaleEffect(scale)
            .animate{ scale = 1 }
        }
        
        if(orientationInfo.orientation == .landscape){
            ZStack{
                VStack{
                   Spacer()
                    VStack{
                        ScrollView{
                            Text(speechRecognizerString)
                                .foregroundColor(.black)
                        }
                        .padding(10)
                    }
                    .frame(width: UIScreen.main.bounds.width/2 - 20, height: 150, alignment: .leading)
                    .background(.white.opacity(0.8))
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.white).opacity(0.5), lineWidth: 1))
                    
                    .simultaneousGesture(
                            LongPressGesture()
                                .onEnded { _ in
                                    print("Cancel chat")
                                    isInChatMode = false
                                    isCatTalk = false
                                    isUserTalk = true
                                }
                        )
                        .highPriorityGesture(
                            TapGesture()
                                .onEnded { _ in
                                    print("Tap cat message")
                                    isCatTalk = true
                                    isUserTalk = false
                                }
                        )
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .bottomTrailing)
            .scaleEffect(scale)
            .animate{ scale = 1 }
        }
    }
}

//layer chứa text nói của cat
struct layer5:View{
    @EnvironmentObject var orientationInfo: OrientationInfo
    @Binding var isCatTalk:Bool
    @Binding var isUserTalk:Bool
    @Binding var isInChatMode:Bool
     var chatBotString:String
    @State var scale = 0.1
    
    //====BODY====//
    var body: some View {
        if(orientationInfo.orientation == .portrait){
            ZStack{
                VStack{
                    Spacer()
                    VStack{
                        ScrollView{
                            Text(chatBotString)
                                .foregroundColor(.black)
                        }
                        .padding(10)
                    }
                    .frame(width: UIScreen.main.bounds.width - 20, height: 150, alignment: .leading)
                   
                    .background(.linearGradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing).opacity(0.7))
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)).opacity(0.5), lineWidth: 1))
                    
                    .simultaneousGesture(
                            LongPressGesture()
                                .onEnded { _ in
                                    print("Cancel chat")
                                    isInChatMode = false
                                    isCatTalk = false
                                    isUserTalk = true
                                }
                        )
                        .highPriorityGesture(
                            TapGesture()
                                .onEnded { _ in
                                    print("Tap cat message")
                                    isCatTalk = false
                                    isUserTalk = true
                                }
                        )
                    
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .scaleEffect(scale)
            .animate{ scale = 1 }
        }
        
        if(orientationInfo.orientation == .landscape){
            ZStack{
                VStack{
                   Spacer()
                    VStack{
                        ScrollView{
                            Text(chatBotString)
                                .foregroundColor(.black)
                        }
                        .padding(10)
                    }
                    .frame(width: UIScreen.main.bounds.width/2 - 20, height: 150, alignment: .leading)
                    
                    .background(.linearGradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing).opacity(0.7))
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)).opacity(0.5), lineWidth: 1))
                    
                    .simultaneousGesture(
                            LongPressGesture()
                                .onEnded { _ in
                                    print("Cancel chat")
                                    isInChatMode = false
                                    isCatTalk = false
                                    isUserTalk = true
                                }
                        )
                        .highPriorityGesture(
                            TapGesture()
                                .onEnded { _ in
                                    print("Tap cat message")
                                    isCatTalk = false
                                    isUserTalk = true
                                }
                        )
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .bottomTrailing)
            .scaleEffect(scale)
            .animate{ scale = 1 }
        }
    }
}
