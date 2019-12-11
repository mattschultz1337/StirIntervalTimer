//
//  ContentView.swift
//  Stir Timer
//
//  Created by Mobile Apps on 12/11/19.
//  Copyright © 2019 Mobile Apps. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var curr: Date = Date()
    @State var timeRemaining = 0.0
    @State var msRemaining = 0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common)
    
    var body: some View {
        NavigationView{
            VStack{
//                Text(timerLogic(from: referenceDate, to: curr)).font(.largeTitle)
                Text(timerLogic(from: Date(timeIntervalSinceNow: timeRemaining) , to: curr) + ":0" + "\(self.msRemaining)" + "ms").font(.largeTitle)
                        .onReceive(timer) { _ in
                            

                            if self.timeRemaining > 0 {
                                if self.msRemaining > 0{
                                    self.msRemaining -= 1
                                } else {
                                    self.msRemaining = 9
                                }
                                self.curr = Date()
                                self.timeRemaining -= 0.1
                            } else{
                                self.msRemaining = 0
                            }
                        }
                
                Button(action: {
                    self.timeRemaining = 10
                    self.curr = Date()
                    self.timer.connect()                }) {
                    Text("START").font(.subheadline)
                }
            }
        }.navigationBarTitle("Stir Timer")
        
    }
}

func timerLogic(from date: Date, to curr: Date) -> String{
    
    let calendar = Calendar(identifier: .gregorian)
    let components = calendar
        .dateComponents([.hour, .minute, .second]
            ,from: curr,
             to: date)
    return String(format: "%02dh:%02d:%02ds",
    components.hour ?? 00,
    components.minute ?? 00,
    components.second ?? 00)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
