//
//  ContentView.swift
//  Oscar
//
//  Created by SWEET HOME (^0^)!!! on 16/11/2023.
//

import SwiftUI


struct ContentView: View {
    
    
    @StateObject private var env = ENVOBJECT()
   
    @State var arr_Model3D_Data = [Model3D_Data(id: 1, name: "Cat idle", modelName: "Cat_IDLE.usdz", details: "Cat_IDLE.usdz"),
                            Model3D_Data(id: 2, name: "Cat eat", modelName: "Cat_EAT.usdz", details: "Cat_EAT.usdz"),
                            Model3D_Data(id: 3, name: "Cat talk", modelName: "Cat_TALK.usdz", details: "Cat_TALK.usdz"),
                            Model3D_Data(id: 4, name: "Cat sleep", modelName: "Cat_SLEEP.usdz", details: "Cat_SLEEP.usdz"),
                            Model3D_Data(id: 5, name: "Cat laught", modelName: "Cat_LAUGHT.usdz", details: "Cat_LAUGHT.usdz"),]
    
  
    
   //====BODY===///
    var body: some View {
        ZStack{
           
            //3d Character view
            MidLayer_3d_View( arr_Model3D_Data: $arr_Model3D_Data, currentModel3DFile: self.env.currentMode.modelName)
           
            //=====UI view=====///
            TopLayer_UI_View(nameOf3dModel: String(env.currentMode.name))
           
            
            //audio service
            //AudioServiceView()
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .environmentObject(self.env)
       
    }
    
}


