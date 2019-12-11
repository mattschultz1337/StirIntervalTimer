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
    var referenceDate: Date = Date(timeIntervalSinceNow: 100)
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.curr = Date()
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Text(timerLogic(from: referenceDate, to: curr)).font(.largeTitle)
                Button(action: {
                    
                    let _ = self.timer
                }) {
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
