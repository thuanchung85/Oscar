//
//  UIView.swift
//  Oscar
//
//  Created by SWEET HOME (^0^)!!! on 16/11/2023.
//

import Foundation
import SwiftUI
struct AvatarView: View {
    let image: Image
    let size: CGFloat
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .cornerRadius(size / 2)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 4)
                    .frame(width: size, height: size)
            )
            .shadow(radius: 10)
    }
}



struct TopLayer_UI_View: View {
    
   
    @State var nameOf3dModel :String
    
    //biến animation button
    @State var appear = false
    
   //====BODY===///
    var body: some View {
        
        //=====UI view=====///
        VStack{
            //name of 3d character
            HStack(alignment: .center){
                
               
                AvatarView(image: Image("avatar"), size: 50)
                            
                  
                Text(nameOf3dModel)
                    .font(.largeTitle)
                    .foregroundStyle(
                        .linearGradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .shadow(.inner(color: .white.opacity(0.2), radius: 0, x: 1, y: 1))
                        .shadow(.inner(color: .white.opacity(0.05), radius: 4, x: 0, y: -4))
                        .shadow(.drop(color: .black.opacity(0.5), radius: 30, y: 30))
                    )
                    .padding(.horizontal,80)
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
                        appear = true
                    }
                }
                .opacity(0.7)
            }
            .frame(width: 350, height: 60, alignment: .center)
            .background(.white.opacity(0.5))
            .cornerRadius(30)
            .padding(.top,20)
            
            
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
                        appear = true
                    }
                }
                .opacity(0.7)
                
            }//end Hstack
            .padding(.bottom,50)
        }//end Vstack
        .padding()
        
       
    }
}
