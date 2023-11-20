//
//  TTSHepler.swift
//  Oscar
//
//  Created by Nguyễn Văn Dươg on 20/04/2023.
//
import AVFoundation
import Foundation
import NaturalLanguage

class TTSHelper {
    let synthesizer = AVSpeechSynthesizer()
    static let shared = TTSHelper()
    private init() {
    }
    func checkLanguage(_ text: String) -> String {
        let languageRecognizer = NLLanguageRecognizer()
        languageRecognizer.processString(text)
        if let dominantLanguage = languageRecognizer.dominantLanguage {
            print(dominantLanguage.rawValue)
            return dominantLanguage.rawValue
        }
        return "vi"
    }
    func StopTTS() {
        self.synthesizer.stopSpeaking(at: .immediate)
    }
    func TTS(_ synthesizer: AVSpeechSynthesizer, text: String) {
        try? AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
        let languageRecognizer = NLLanguageRecognizer()
        languageRecognizer.processString(text)
        if let dominantLanguage = languageRecognizer.dominantLanguage {
            print(dominantLanguage.rawValue)

            let voices = AVSpeechSynthesisVoice.speechVoices()
            if let voice = voices.first(where: { $0.language.lowercased().contains("\(dominantLanguage.rawValue)".lowercased())}) {
                print("\(voice.language)")
                let utterance = AVSpeechUtterance(string: text)
                let voice = AVSpeechSynthesisVoice(language: voice.language)
                utterance.rate = 0.52
                utterance.volume = 1.0
                utterance.voice = voice
                synthesizer.speak(utterance)
            }

        }
    }
    
    func TTS(_ text: String) {
        let languageRecognizer = NLLanguageRecognizer()
        languageRecognizer.processString(text)
        if let dominantLanguage = languageRecognizer.dominantLanguage {
            print(dominantLanguage.rawValue)

            let voices = AVSpeechSynthesisVoice.speechVoices()
            if let voice = voices.first(where: { $0.language.lowercased().contains("\(dominantLanguage.rawValue)".lowercased())}) {
                print("\(voice.language)")
                let utterance = AVSpeechUtterance(string: text)
                let voice = AVSpeechSynthesisVoice(language: voice.language)
                utterance.rate = 0.52
                utterance.volume = 1.0
                utterance.voice = voice
                self.synthesizer.speak(utterance)
            }

        }
    }
}


class SpeechSynthesizer: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    let synthesizer = AVSpeechSynthesizer()
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    @Published var isSpeaking = false
        
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = true
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = false
        }
    }
}
