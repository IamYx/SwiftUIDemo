//
//  ContentView.swift
//  YXSwiftUIDemo
//
//  Created by 姚肖 on 2023/4/3.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var isLoading = false
    @State var subText : String = "内容:"
    @State var inputText = ""
    @State var outputText = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var hiddenDetail : Bool
    @Binding var selectTabbar : Int

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            let str = "\(item.timestamp!, formatter: itemFormatter)"
                            FirstView(content: item.name ?? "暂无数据", timeStr: str, subText: $subText)
                        } label: {
                            VStack {
                                HStack {
                                    Text(subText)
                                    Text(item.name ?? "暂无数据")
                                }.frame(width: 320.0, height: 30, alignment: .leading)
                                Text(item.timestamp!, formatter: itemFormatter)
                                    .frame(width: 320.0, height: 20, alignment: .leading)
                            }
                        }
                        
                        /** 模态出详情页面
                        Button(action: {
                            hiddenDetail.toggle()
                        }) {
                            Spacer()
                            Text(item.name ?? "暂无数据")
                            Spacer()
                        }
                        .fullScreenCover(isPresented: $hiddenDetail) {
                            let str = "\(item.timestamp!, formatter: itemFormatter)"
                            FirstView(content: item.name ?? "暂无数据", timeStr: str, subText: $subText)
                        }
                        **/
                        
                    }.onDelete(perform: deleteItems)
                }.listStyle(.plain)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem {
                            Button(action: addItem) {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("My App")
                                .font(.title3)
                                .foregroundColor(.orange)
                        }
                    }
                
                CustomTabBar(selectTabbar: $selectTabbar)
                
            }
        }.overlay(
            Group {
                if isLoading {
                    ZStack {
                        Color.white.opacity(0.5)
                            .ignoresSafeArea()
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                }
            }
        )
    }
    
    private func addItem() {
        getJoke()
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func getJoke() {
        
        isLoading = true
        //https://api.oick.cn/lishi/api.php
        guard let url = URL(string: "https://api.oick.cn/dutang/api.php") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data returned from API.")
                return
            }
            
            let str = String(data: data, encoding: .utf8)
            print(str ?? "解析错误")
            
            DispatchQueue.main.async {
                isLoading = false
                withAnimation {
                    let newItem = Item(context: viewContext)
                    newItem.timestamp = Date()
                    newItem.name = str ?? "解析错误"
                    
                    do {
                        try viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
            }
        }
        task.resume()
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter
}()

struct Joke: Codable {
    let value: String
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(hiddenTabBar: false).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ date: Date, formatter: DateFormatter) {
        appendLiteral(formatter.string(from: date))
    }
}

struct FlipTransition: ViewModifier {
    let isActive: Bool

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(isActive ? 180 : 0), axis: (x: 0, y: 1, z: 0))
    }
}

extension AnyTransition {
    static var flip: AnyTransition {
        .modifier(active: FlipTransition(isActive: true), identity: FlipTransition(isActive: false))
    }
}

