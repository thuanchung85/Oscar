//
//  AppService.swift
//  Oscar
//
//  Created by SWEET HOME (^0^)!!! on 16/11/2023.
//

import SwiftUI
class ENVOBJECT:ObservableObject {
    @Published var isPresented = false
    @Published var currentMode:Model3D_Data = Model3D_Data(id: 1, name: "Cat_IDLE.usdz", modelName: "Cat_IDLE.usdz", details: "Cat_IDLE.usdz")
}
