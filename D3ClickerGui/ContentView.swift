import SwiftUI
import Foundation
import Schedule

let source = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)


func pressKey(key: UInt16) {
    let location = CGEventTapLocation.cghidEventTap

    let keyDown = CGEvent(keyboardEventSource: source, virtualKey: key, keyDown: true)
    let keyUp = CGEvent(keyboardEventSource: source, virtualKey: key, keyDown: false)

    keyDown?.post(tap: location)
    keyUp?.post(tap: location)
}

let pressOne = true
let pressTwo = false
let pressThree = true
let pressFour = true

let everySecondPlan = Plan.every(1.seconds)
let task = everySecondPlan.do {
    if(pressOne) {
        pressKey(key: 0x12)
    }
    if(pressTwo) {
        pressKey(key: 0x13)
    }
    if(pressThree) {
        pressKey(key: 0x14)
    }
    if(pressFour) {
        pressKey(key: 0x15)
    }
}

struct ContentView: View {

    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            HStack {
                Button(action: {
                    task.resume()
                }, label: {
                    Text("Start Clicking")
                })
                Button(action: {
                    task.suspend()
                }, label: {
                    Text("Stop Clicking")
                })
            }
        })
    }
    
    init() {
        task.suspend()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
