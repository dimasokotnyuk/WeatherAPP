//
//  ShimmerEffect.swift
//  SwiftUI-Weather
//
//  Created by Дмитро Сокотнюк on 05.07.2025.
//

import SwiftUI

struct ShimmerEffect: ViewModifier {
    @State private var isAnimating = false
    
    // Властивості для налаштування
    private let animation = Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false)
    private let rotation: Double = 5
    
    func body(content: Content) -> some View {
        content
            // content.drawingGroup() може покращити продуктивність складних View
            .overlay(
                GeometryReader { geometry in
                    let size = geometry.size
                    // Розрахунки для руху за межами елемента
                    let skeletonWidth = size.width / 2
                    let blurRadius = max(skeletonWidth / 2, 15)
                    let blurDiameter = blurRadius * 2
                    
                    // minX: починаємо зліва за межами
                    let minX = -(skeletonWidth + blurDiameter)
                    // maxX: закінчуємо справа за межами
                    let maxX = size.width + skeletonWidth + blurDiameter
                    
                    Rectangle()
                        // Градієнт для більш м'якого ефекту " полиску"
                        .fill(.linearGradient(
                            colors: [
                                .white.opacity(0.05),
                                    .white.opacity(0.7),
                                    .white.opacity(0.05)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(width: skeletonWidth, height: size.height)
                        .blur(radius: blurRadius)
                        .rotationEffect(.init(degrees: rotation))
                        .blendMode(.softLight)
                        .offset(x: isAnimating ? maxX : minX)
                }
                .compositingGroup() // Групуємо для кращої продуктивності
            )
            .onAppear {
                // Запускаємо анімацію при появі View
                withAnimation(animation) {
                    isAnimating = true
                }
            }
            .mask(content)
    }
}

// 2. Створюємо зручне розширення, щоб викликати модифікатор
extension View {
    func shimmering() -> some View {
        self.modifier(ShimmerEffect())
    }
}

#Preview {
   Rectangle()
        .fill(.green)
        .frame(width: 300, height: 200)
        .shimmering()
}
