//
//  PlayerView.swift
//  WhiteNoise-SwiftUI
//
//  Created by Александра Башкирова on 28.06.2020.
//  Copyright © 2020 Alexandra Bashkirova. All rights reserved.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var viewModel: PlayerViewModel
    private var volume: Double
    @State var minutes: Int = 1
    @State var startPlayDate: Date?
    @State var timeString = ""
    @State var timeRemain: Int = 30
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(viewModel: PlayerViewModel) {
        self.viewModel = viewModel
        self.volume = viewModel.volume
    }

    var volumeSlider: some View {
        
        HStack {
            Text("Volume")
                .foregroundColor(.gray)
            Slider(
                value: Binding(get: {
                    self.viewModel.volume
                }, set: { (newVal) in
                    self.viewModel.volume = newVal
                    self.volumeChanged()
                }),
                in: 0...1,
                step: 0.01)
        }
    }

    var body: some View {
        HStack(spacing: 12.0) {
            Button(action: {
                self.playTapped()
            }) {
                viewModel.isPlayed ? Image("Pause") : Image("Play")
            }
            .buttonStyle(PlainButtonStyle())
            
            if viewModel.isPlayed {
                
                Text("\(timeString)")
                    .onReceive(timer) { _ in
                        print("timer \(timeRemain)")
                        timeString = self.stringFromDate(date: startPlayDate ?? Date())
                        if timeRemain > 0 {
                            timeRemain -= 1
                        } else {
                            self.playTapped()
                        }
                    }
                    .foregroundColor(.gray)
                    .frame(width:120)
                
            } else {
                Picker("", selection: $minutes){
                    let times = [30, 60, 90]
                    ForEach(times, id: \.self) { i in
                        Text("\(i) min")
                            .foregroundColor(.black)
                    }
                }
                .pickerStyle(PopUpButtonPickerStyle())
                .frame(width:120)
            }
            
            volumeSlider
        }
        .foregroundColor(.clear)
    }

    func playTapped() {
        timeRemain = minutes * 60
        startPlayDate = Date()
        viewModel.playChange()
    }

    func volumeChanged() {
        viewModel.volumeChanged()
    }
    
    private func stringFromDate(date: Date) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.maximumUnitCount = 2
        return formatter.string(from: date, to: Date()) ?? ""
    }
}

#if DEBUG
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayerView(viewModel: PlayerViewModel(volume: 1.0, isPlayed: true))
            PlayerView(viewModel: PlayerViewModel(volume: 0.5, isPlayed: false))
        }
        .previewLayout(.fixed(width: 300, height: 100))
    }
}
#endif
