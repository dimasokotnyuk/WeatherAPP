//
//  Weather10DaysPlaceholder.swift
//  SwiftUI-Weather
//
//  Created by Дмитро Сокотнюк on 05.07.2025.
//

import SwiftUI

struct Weather10DaysPlaceholder: View {
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundStyle(.white)
                Text("10-day weather forecast")
                    .foregroundStyle(.white)
            }
            .padding(.vertical, 10)
            
            CustomDivider()
            
            ForEach(0..<10) { index in
                HStack(spacing: 16) {
                    // День тижня - фіксована ширина
                    Text(index == 0 ? "Current" : "Mon")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundStyle(.white)
                        .frame(width: 60, alignment: .leading)
                        .redacted(reason: .placeholder)
                        .shimmering()
                    
                    // Іконка погоди - центрування
                    Image(.sun)
                        .symbolRenderingMode(.multicolor)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .redacted(reason: .placeholder)
                        .shimmering()
                    
                    Spacer()
                    
                    // Температура - вирівнювання по правому краю
                    Text("15° - 30°")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundColor(.white.opacity(0.8))
                        .redacted(reason: .placeholder)
                        .shimmering()
                    
                    Spacer()
                    
                    Text("\(Image(systemName: "wind")) - 18 km/h")
                        .lineLimit(1)
                        .foregroundStyle(.white)
                        .redacted(reason: .placeholder)
                        .shimmering()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                // Роздільник (крім останнього елемента)
                if index < 10 - 1 {
                    CustomDivider()
                }
            }
        }
        .padding(.vertical, 8)
        .background(.ultraThinMaterial.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9) // 90% ширини екрану
    }
}

#Preview {
    Weather10DaysPlaceholder()
}
