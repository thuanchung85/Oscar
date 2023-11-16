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
    typealias UIViewType = SCNView
    typealias Context = UIViewRepresentableContext<MySceneView>

    func updateUIView(_ uiView: UIViewType, context: Context) {}
    func makeUIView(context: Context) -> UIViewType {
        let view = SCNView()
        view.backgroundColor = UIColor.clear // this is key!
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        // load the object here, could load a .scn file too
        view.scene = SCNScene(named: "Cat_IDLE.usdz")!
        return view
    }
}

struct MidLayer_3d_View: View {
    var arr_Model3D_Data = [Model3D_Data(id: 1, name: "Cat_IDLE.usdz", modelName: "Cat_IDLE.usdz", details: "Cat_IDLE.usdz")]
    //====BODY===///
    var body: some View {
        //===3d model view====///
        VStack {
            ZStack{
                Image("bg")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                MySceneView()
                    .frame( // set frame as required
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center
                    )
                
            }
        }//end Vstack
    }
}
