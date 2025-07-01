//
//  CustomDivider.swift
//  SwiftUI-Weather
//
//  Created by Дмитро Сокотнюк on 05.07.2025.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.white.opacity(0.5))
            .frame(height: 0.5)
            .cornerRadius(2)
            .padding(4)
    }
}

#Preview {
    CustomDivider()
}
