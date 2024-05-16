//
//  YXPublicView.swift
//  YXSwiftUIDemo
//
//  Created by 姚肖 on 2023/11/10.
//

import SwiftUI

struct CardView: View {
    let cardNumber: Int
    @State private var backgroundColor = Color.white
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(backgroundColor)
            .frame(width: ((UIScreen.screens.first?.bounds.width ?? 240) - 40.00), height: 150)
            .overlay(
                
                HStack {
                    
                    Image("123")
                        .resizable()
                        .frame(width: 80, height: 80)
                    
                    Text("Card \(cardNumber)")
                        .foregroundColor(.black)
                        .font(.title)
                }
                
            )
            .shadow(radius: 5)
            .onTapGesture {
                self.backgroundColor = Color.red
            }
    }
}
