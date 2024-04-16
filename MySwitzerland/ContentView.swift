//
//  ContentView.swift
//  iOS Emoji Picker
//
//  Created by Jonas Vetsch on 16.04.2024.
//

import SwiftUI
import AVFoundation

enum Emoji: String, CaseIterable {
    case 🏔️, 🇨🇭, 🧀, 🥳, 🥾
}

class AudioPlayer {
    var audioPlayer: AVAudioPlayer?

    func startPlayback(audio: String) {
        guard let bundlePath = Bundle.main.path(forResource: audio, ofType: "mp3") else {
            print("Audio file not found")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: bundlePath))
            audioPlayer?.play()
        } catch {
            print("Playback failed.")
        }
    }

    func stopPlayback() {
        audioPlayer?.stop()
    }
}

struct ContentView: View {
    @State var selection: Emoji = .🇨🇭
    
    private var audioPlayer = AudioPlayer()
    
    var body: some View {
        NavigationView{
            VStack {
                
                Text(selection.rawValue)
                    .font(.system(size: 150))
                
                Picker("Select Emoji", selection: $selection) {
                    ForEach(Emoji.allCases, id: \.self) { emoji in
                        Text(emoji.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Spacer()
                
                HStack{
                    Text("Add some ambience")
                        .padding()
                    
                    Button("Play") {
                        audioPlayer.startPlayback(audio: "oergelimusik")
                    }
                    .font(.headline)
                    .padding(12)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    
                    Button("Stop") {
                        audioPlayer.stopPlayback()
                    }
                    .font(.headline)
                    .padding(12)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                }
            }
            .navigationTitle("My Switzerland")
            .padding()
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    ContentView()
}
