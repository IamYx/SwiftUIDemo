//
//  FirstView.swift
//  YXSwiftUIDemo
//
//  Created by 姚肖 on 2023/4/3.
//

import SwiftUI
import WebKit

struct FirstView : View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State public var content : String
    @State public var timeStr : String
    @State private var isAnim = false
    @Binding var subText : String
    
    var body: some View {
        /**不需要的返回按钮
        HStack() {
            Spacer().frame(width: 20)
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("back").font(.system(size: 20))
            }
            Spacer()
        }
        **/
        NavigationView {
            GeometryReader { geometry in
                
                ScrollView {
                    
                    WebView(url: URL(string: "https://www.baidu.com")!).frame(width: geometry.size.width, height: 300, alignment: .center)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text(timeStr)
                        
                        Text(content)
                        
                        Text("show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page")
                        
                        Text("show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page")
                        
                        Text("show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page")
                        
                        Text("show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page")
                        
                        Text("show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page")
                        
                        Text("show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page show text in first page show text in first12 page show text in first page show text in first page show text in first page show text in first page")

                    }.padding()
                    
                    
                    HStack {
                        
                        Button {
                            withAnimation {
                                subText = "|||"
                                isAnim.toggle()
                            }
                        } label: {
                            Text("change")
                                .font(.system(size: 20))
                        }
                        .sheet(isPresented: $isAnim) {
                            Image("123")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.black)
                                .edgesIgnoringSafeArea(.all)
                                .transition(.move(edge: .leading))
                                .onTapGesture {
                                    self.isAnim = false
                                }
                        }
                    }.frame(width: 70, height: 40, alignment: .trailing)
                        .position(x: geometry.size.width - 70, y: 10)
                    
                }.background(.white)
                    .frame(width: geometry.size.width, height: geometry.size.height - 1, alignment: .top)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
            
        }
        .navigationTitle("详情")
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}

struct NextView : View {
    
    @State var content = NSMutableAttributedString(string: "detail")
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            ScrollView {
                Text(content.string)
                    .onTapGesture {
                        let index = Int(arc4random_uniform(10000)) + 1
                        YXNetwork.shared.getJokeWithGet(url: "http://v3.wufazhuce.com:8000/api/essay/\(index)") { data in
                            //                        content = data
                            
                            let dic : NSDictionary = YXNetwork.shared.jsonStringToDictionary(jsonString: data)! as NSDictionary
                            if dic["data"] != nil {
                                let dic2 : NSDictionary = dic["data"] as! NSDictionary
                                if dic2["hp_content"] != nil {
                                    let tagText = dic2["hp_content"] as! String
                                    
                                    content = NSMutableAttributedString(string: tagText)
                                }
                            }
                        }
                    }
            }
            Spacer()
        }
    
    }
}

struct UIKitViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = DetailViewController()
        viewController.navigationItem.title = "详情页面"
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // 可选：在需要更新UIKit页面时执行的操作
    }
}
