//
//  ContentView.swift
//  Oscar
//
//  Created by SWEET HOME (^0^)!!! on 16/11/2023.
//

import SwiftUI


struct ContentView: View {
    
   
   
    
    
   //====BODY===///
    var body: some View {
        ZStack{
            
            
         
            MidLayer_3d_View()
            
            //=====UI view=====///
            TopLayer_UI_View(nameOf3dModel: "CAT")
           
        }
       
    }
}


