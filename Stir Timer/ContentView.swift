//
//  ContentView.swift
//  Stir Timer
//
//  Created by Mobile Apps on 12/11/19.
//  Copyright © 2019 Mobile Apps. All rights reserved.
//

import SwiftUI
import Foundation
import AVFoundation
struct ContentView: View {
    
    @State var curr: Date = Date()
    @State var timeRemaining = 0.0
    @State var minRemaining = 0
    @State var msRemaining = 0
    @State private var hselection = 0
    @State private var mselection = 0
    @State private var sselection = 0
    @State var pause = false
    

    let colors = ["Red","Yellow","Green","Blue"]
    let timer = Timer.publish(every: 0.01, on: .main, in: .common)
    
    var body: some View {
        VStack{
            Button(action: {
                var playsound: AVAudioPlayer?
                do {
                    playsound = try AVAudioPlayer(contentsOf: URL(string: "/Users/mobile/Library/Developer/CoreSimulator/Devices/55BAE8BB-A119-4EC2-9D68-A45CDF7B7B33/data/Containers/Bundle/Application/6CB7F2A9-734C-47A1-A34A-35884AD2F4FE/Stir Timer.app/alarm.mp3")!)
                    playsound?.play()
                } catch {
                    // couldn't load file :(
                }
            }) {
                Text("PLAY").font(.subheadline).bold()
            }
            Group{
                HStack{
                    Spacer().frame(width: 38)
                Text(timerLogic(from: Date(timeIntervalSinceNow: timeRemaining) , to: curr) + "." + intTodubString(ms: self.msRemaining) ).font(.system(size: 53)).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .onReceive(timer) { _ in
                        
                        
                        if self.timeRemaining > 0 && !self.pause{
                            if self.msRemaining > 0{
                                self.msRemaining -= 1
                            } else {
                                self.msRemaining = 99
                            }
                            self.curr = Date()
                            self.timeRemaining -= 0.01
                        } else if !self.pause{
                            self.msRemaining = 0
                                                    }
                }
                    Spacer().frame(width: 25)
                }
                Spacer().frame(height: 25)
            }
            
            HStack{
                Group{
                    Button(action: {
                        if !self.pause{
                            self.timeRemaining = Double(self.sselection + (60 * self.mselection) + (3600 * self.hselection))
                            self.curr = Date()
                            self.timer.connect()
                        } else{
                            self.pause = false
                        }
                    }) {
                        Text("START").font(.subheadline).bold()
                    }
                    Spacer().frame(width: 70)
                    Button(action: {
                        self.pause = true
                        
                    }) {
                        Text("STOP").font(.subheadline).bold()
                    }
                    Spacer().frame(width: 70)
                    Button(action: {
                        self.hselection = 0
                        self.mselection = 0
                        self.sselection = 0
                        self.timeRemaining = 0
                        self.pause = false
                        self.curr = Date()
                        self.timer.connect()                }) {
                            Text("RESET").font(.subheadline).bold()
                    }
                }
            }
            HStack{
                Picker("Hours", selection: $hselection) {
                   
                    ForEach(0..<25) {
                        Text("\($0) hours")
                    }
                    
                    
                }
                .labelsHidden().frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                Picker("Minutes", selection: $mselection) {
                    

                    ForEach(0..<60) {
                        Text("\($0) mins")
                    }
                                    }
                .labelsHidden().frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                Picker("Seconds", selection: $sselection) {
                
                    ForEach(0..<60) {
                        Text("\($0) secs")
                    }
                    
                }
                .labelsHidden().frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }.frame(height: 200)
            
            
            
            
        }
        //
        //
        
        
    }
}

func intTodubString(ms: Int) -> String{
    
    return String(format: "%02d", ms)

}
func playSound(soundName: String) { //
     
//    let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
//    player = try! AVAudioPlayer(contentsOf: url!)
//    player?.play()
}
func timerLogic(from date: Date, to curr: Date) -> String{
    
    let calendar = Calendar(identifier: .gregorian)
    let components = calendar
        .dateComponents([.hour, .minute, .second]
            ,from: curr,
             to: date)
    return String(format: "%02d:%02d:%02d",
                  components.hour ?? 00,
                  components.minute ?? 00,
                  components.second ?? 00)
}

struct Player{
    static let shared = Player()
    var alarmsound: AVAudioPlayer?
    
    private init(){
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
