//
//  SplashScreen.swift
//  FinSight
//
//  Created by Macbook Pro on 02/06/2025.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var scale = 0.7
    @State private var opacity = 0.5
    @State private var rotation = 0.0
    @State private var waveOffset = Angle(degrees: 0)
    
    let primaryColor = Color(red: 0.5, green: 0.2, blue: 0.8)  // Purple base
    let secondaryColor = Color(red: 0.7, green: 0.4, blue: 1.0) // Lighter purple
    
    var body: some View {
        if isActive {
            // Your main content view would go here
            ContentView()
        } else {
            ZStack {
                // Gradient background
                LinearGradient(
                    gradient: Gradient(colors: [primaryColor, secondaryColor]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Animated wave pattern at bottom
                WaveShape(offset: waveOffset)
                    .fill(primaryColor.opacity(0.3))
                    .frame(height: 100)
                    .offset(y: 50)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                            waveOffset = Angle(degrees: 360)
                        }
                    }
                
                VStack {
                    // Animated logo/icon
                    ZStack {
                        Circle()
                            .fill(secondaryColor)
                            .frame(width: 120, height: 120)
                            .shadow(color: .white.opacity(0.3), radius: 10, x: 0, y: 0)
                            .scaleEffect(scale)
                        
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(rotation))
                    }
                    
                    // App title with typing animation
                    TypingText(text: "Finance Analytics", speed: 0.1)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top, 30)
                    
                    // Subtitle with fade-in
                    Text("Smart insights for your finances")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.top, 10)
                        .opacity(opacity)
                }
            }
            .onAppear {
                // Logo animation sequence
                withAnimation(.easeInOut(duration: 0.7)) {
                    scale = 1.0
                    opacity = 1.0
                }
                
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
                
                // Move to next screen after animations complete
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

// Wave shape for the animated bottom wave
struct WaveShape: Shape {
    var offset: Angle
    
    var animatableData: Angle {
        get { offset }
        set { offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let waveHeight = rect.height * 0.25
        
        path.move(to: CGPoint(x: 0, y: rect.height))
        
        for x in stride(from: 0, through: rect.width, by: 5) {
            let relativeX = x / rect.width
            let sine = sin(relativeX * .pi * 4 + offset.radians)
            let y = waveHeight * CGFloat(sine) + rect.height - waveHeight
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        
        return path
    }
}

// Typing text effect
struct TypingText: View {
    let text: String
    let speed: TimeInterval
    
    @State private var displayedText = ""
    @State private var counter = 0
    
    var body: some View {
        Text(displayedText)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { timer in
                    if counter < text.count {
                        let index = text.index(text.startIndex, offsetBy: counter)
                        displayedText += String(text[index])
                        counter += 1
                    } else {
                        timer.invalidate()
                    }
                }
            }
    }
}


#Preview {
    SplashScreen()
}
