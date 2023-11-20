//
//  AppConfiguration.swift
//  Oscar
//
//  Created by Admin on 20/11/2023.
//
import Foundation

final class AppConfiguration {
    lazy var apiGPTKey: String = {
        guard let apiGPTKey = Bundle.main.object(forInfoDictionaryKey: "ApiGPTKey") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiGPTKey
    }()
    
}
