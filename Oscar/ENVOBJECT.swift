//
//  AppService.swift
//  Oscar
//
//  Created by SWEET HOME (^0^)!!! on 16/11/2023.
//

import SwiftUI
class ENVOBJECT:ObservableObject {
    @Published var arr_Text = ["안녕하세요 고양이입니다","요즘 어떻게 지내니?",
                               "오늘 날씨가 아주 좋아요","저는 소녀시대 팬인데, 당신은 어떤가요?",
                                "한국인들은 너무 똑똑해서 많은 발명품이 한국에서 나옵니다.","한국으로 여러분을 초대합니다. 흥미로운 것들도 많고, 아름다운 풍경도 있고, 음식도 아주 훌륭합니다.",
    "저는 한국 영화를 자주 보는 걸 좋아하는데, 특히 로맨틱 장르를 좋아하는데, 어떤 장르를 좋아하시나요?", "우리 가족은 절대 고장이 나지 않는 삼성 TV를 가지고 있습니다."]
    @Published var isPresented = false
    @Published var currentMode:Model3D_Data = Model3D_Data(id: 1, name: "Cat", modelName: "Cat_IDLE.usdz", details: "Cat_IDLE.usdz")
}
