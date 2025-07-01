//
//  BackgroundView.swift
//  SwiftUI-Weather
//
//  Created by Дмитро Сокотнюк on 05.07.2025.
//

import SwiftUI

struct BackgroundView: View {
    
    var body: some View {
        Image(.backgroundGradient)
            .resizable()
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
