//
//  MidLayer_3d_View.swift
//  Oscar
//
//  Created by SWEET HOME (^0^)!!! on 16/11/2023.
//

import Foundation
import SceneKit
import SwiftUI

struct MySceneView: UIViewRepresentable {
     var currentModel3DFile:String
    let mySceneView = SCNView()
    typealias UIViewType = SCNView
    typealias Context = UIViewRepresentableContext<MySceneView>

    func updateUIView(_ uiView: UIViewType, context: Context) {
        
       print("updateUIView for \(currentModel3DFile)")
       
        uiView.scene = nil
        uiView.scene = SCNScene(named: currentModel3DFile )!
    }
    
    func makeUIView(context: Context) -> UIViewType {
        
        mySceneView.backgroundColor = UIColor.clear // this is key!
        mySceneView.allowsCameraControl = true
        mySceneView.autoenablesDefaultLighting = true
        // load the object here, could load a .scn file too
        mySceneView.scene = SCNScene(named: currentModel3DFile )!
       
        return mySceneView
    }
    
    
}

struct MidLayer_3d_View: View {
   
    @Binding var  arr_Model3D_Data:[Model3D_Data]
     var currentModel3DFile: String
    
    @EnvironmentObject private var env: ENVOBJECT
    
    //====BODY===///
    var body: some View {
        //===3d model view====///
        VStack {
            ZStack{
                Image("bg")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                //let sc = SCNScene(named: self.currentModel3DFile)
               /*
                SceneView(scene: { () -> SCNScene in
                    var scene = SCNScene(named: currentModel3DFile )
                    scene!.backgroundColor = UIColor.clear
                    return scene!
                }(),
                          options:[.autoenablesDefaultLighting,.allowsCameraControl])
                    .frame( // set frame as required
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center
                    )
                
                    .onTapGesture {
                        print("tap model")
                        
                        env.currentMode = arr_Model3D_Data.randomElement()!
                    }
                */
                
                MySceneView(currentModel3DFile:currentModel3DFile)
                    .frame( // set frame as required
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center
                    )
                    .onTapGesture {
                        print("tap model")
                        
                        env.currentMode = arr_Model3D_Data.randomElement()!
                    }
                
            }
        }//end Vstack
        
        
        
        
    }//end body
}
