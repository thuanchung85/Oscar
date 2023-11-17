//
//  UIView.swift
//  Oscar
//
//  Created by SWEET HOME (^0^)!!! on 16/11/2023.
//

import Foundation
import SwiftUI



struct TopLayer_UI_View: View {
    
   
    var nameOf3dModel :String
    
    
    
   //====BODY===///
    var body: some View {
       
            ZStack{
                
                Layer1()
                    .environmentObject(OrientationInfo())
                
                Layer2()
                    .environmentObject(OrientationInfo())
                
                Layer3(nameOf3dModel:nameOf3dModel)
                    .environmentObject(OrientationInfo())
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        
    }
}



//layer chưa nút micro
struct Layer1:View{
   
    @EnvironmentObject var orientationInfo: OrientationInfo
    
    //===BODY===//
    var body: some View {
        if(orientationInfo.orientation == .portrait){
            VStack(alignment: .center) { // explicit container with center default alignment
                Spacer()
                //====BUTTON MICRO====//
                HStack{
                    Button(action: {
                        print("Circular Button tapped")
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
                        print("Circular Button tapped")
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
                            .shadow(.inner(color: .white.opacity(0.2), radius: 0, x: 1, y: 1))
                            .shadow(.inner(color: .white.opacity(0.05), radius: 4, x: 0, y: -4))
                            .shadow(.drop(color: .black.opacity(0.5), radius: 30, y: 30))
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
                .padding(.top,10)
                .padding(.trailing,10)
                Spacer()
                
                
                
                
            }//end Vstack
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .trailing)
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
                            .shadow(.inner(color: .white.opacity(0.2), radius: 0, x: 1, y: 1))
                            .shadow(.inner(color: .white.opacity(0.05), radius: 4, x: 0, y: -4))
                            .shadow(.drop(color: .black.opacity(0.5), radius: 30, y: 30))
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
