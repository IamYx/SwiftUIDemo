//
//  File.swift
//  YXSwiftUIDemo
//
//  Created by 姚肖 on 2023/11/9.
//

import SwiftUI

struct HistoryToday : View {
    
    @State private var currentIndex = 0
    @State private var timer: Timer?
    @Binding var selectTabbar : Int
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer().frame(height: 10)
                
                ScrollViewReader { scrollViewProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(1...100, id: \.self) { index in
                                CardView(cardNumber: index)
                            }
                        }
                        .padding()
                        .onChange(of: currentIndex) { newValue in
                            scrollToView(viewIndex: newValue, scrollViewProxy: scrollViewProxy)
                        }
                    }
                    .frame(height: 200)
                    .onAppear {
                        startTimer()
                    }
                    .onDisappear {
                        stopTimer()
                    }
                }
                
                Text("this is a scrollView")
                
                List {
                    ForEach(1...100, id: \.self) { index in
                        
                        NavigationLink(destination: UIKitViewController().navigationTitle("详情页面")) {
                            Text("session \(index)")
                                .frame(height: 50)
                        }
                        
                    }
                }.listStyle(.plain)
                
                Spacer()
                
                CustomTabBar(selectTabbar: $selectTabbar)
            }
        }
    }
    
    func scrollToView(viewIndex: Int, scrollViewProxy: ScrollViewProxy) {
        withAnimation {
            scrollViewProxy.scrollTo(viewIndex, anchor: .center)
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            currentIndex += 1
            if currentIndex > 100 {
                currentIndex = 1
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

}


//struct ContentView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        HistoryToday()
//    }
//}
