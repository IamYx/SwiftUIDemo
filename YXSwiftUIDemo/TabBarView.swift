//
//  TabBarView.swift
//  YXSwiftUIDemo
//
//  Created by 姚肖 on 2023/4/4.
//

import SwiftUI

struct TabBarView : View {
    
    @State var hiddenTabBar : Bool = false
    @State private var selectedIndex = 0
    
    var body: some View {
        let tabBarSettings: TabView = TabView(selection: $selectedIndex, content: {
            ContentView(hiddenDetail: $hiddenTabBar, selectTabbar: $selectedIndex)
                .tabItem {
                    Label("毒鸡汤", systemImage: "1.circle")
                }
                .tag(0)
            HistoryToday(selectTabbar: $selectedIndex)
                .tabItem {
                    Label("历史今天", systemImage: "2.circle")
                }
                .tag(1)
        })
        
        tabBarSettings
            .onAppear {
                UITabBar.appearance().isHidden = true
            }
        
    }
}

struct CustomTabBar : View {
    
    @Binding var selectTabbar : Int
    @State var oneTextColor = Color.gray
    @State var twoTextColor = Color.gray
    
    var body: some View {
        HStack {
            
            Text("one")
                .foregroundColor(oneTextColor)
                .font(.title2)
                .onTapGesture {
                    selectTabbar = 0
                }
            Spacer().frame(width: 20)
            Text("two")
                .foregroundColor(twoTextColor)
                .font(.title2)
                .onTapGesture {
                    selectTabbar = 1
                }
            
        }.onAppear {
            if (selectTabbar == 0) {
                oneTextColor = .orange
                twoTextColor = .gray
            } else {
                oneTextColor = .gray
                twoTextColor = .orange
            }
        }
    }
}
