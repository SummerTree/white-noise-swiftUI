//
//  CategoryCardView.swift
//  WhiteNoise-SwiftUI
//
//  Created by Александра Башкирова on 28.06.2020.
//  Copyright © 2020 Alexandra Bashkirova. All rights reserved.
//

import SwiftUI

struct CategoryCardView: View {
    @ObservedObject var viewModel: CategoryCardViewModel
    @State var timeString = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(viewModel: CategoryCardViewModel) {
        self.viewModel = viewModel
    }
    
    var placeholder: some View {
        PlaceholderCategoryCardView()
    }

    var body: some View {
        if
            let title = viewModel.title,
            let image = viewModel.imageName,
            let number = viewModel.numberAudio,
            let description = viewModel.description
        {
            return AnyView(
                createCard(
                    title: title,
                    image: image,
                    number: number,
                    desctiption: description,
                    startPlayDate: viewModel.startPlayDate)
            )
        } else {
            return AnyView(placeholder)
        }
    }
    
    private func createCard(title: String, image: String, number: String, desctiption: String, startPlayDate: Date?) -> some View {
        return VStack(alignment: .leading, spacing: 10.0) {
                Text(title)
                    .font(.system(size: 32.0, weight: .semibold, design: .rounded))
                    .foregroundColor(.gray)
                ZStack {
                    GeometryReader { geometry in
                        Image(image)
                            .resizable()
                            .scaledToFill()
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack(alignment: .bottom) {
                                Text(number)
                                    .font(.system(size: 54.0, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                if let startPlayDate = viewModel.startPlayDate {
                                    Text("\(timeString)")
                                        .onReceive(timer) { _ in
                                            timeString = self.stringFromDate(date: startPlayDate)
                                        }
                                        .font(.system(size: 16.0, weight: .regular, design: .rounded))
                                        .foregroundColor(.white)
                                        .lineLimit(nil)
                                        .padding([.trailing, .bottom], 16.0)
                                }
                                
                            }
                            Text(desctiption)
                                .font(.system(size: 16.0, weight: .regular, design: .rounded))
                                .foregroundColor(.white)
                                .lineLimit(nil)
                                .padding(.trailing, 8.0)
                        }
                        .padding([.leading, .bottom], 32.0)
                     }
                    .edgesIgnoringSafeArea([.top, .bottom])
                }
                .aspectRatio(0.58, contentMode: .fit)
                .cornerRadius(12)
                .shadow(radius: 10)
                .padding(.trailing, 64.0)
           
        }
        .foregroundColor(.clear)
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
struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryCardView(
            viewModel: CategoryCardViewModel(
                category: CategoryRepositoryImpl().getCategory(by: "Natural")!))
            CategoryCardView(
            viewModel: CategoryCardViewModel(
                category: nil))
        }
        .previewLayout(.fixed(width: 300, height: 300))
        
    }
}
#endif
