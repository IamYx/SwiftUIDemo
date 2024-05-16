//
//  Network.swift
//  YXSwiftUIDemo
//
//  Created by 姚肖 on 2023/11/10.
//

import Foundation

class YXNetwork : NSObject {
    
    static let shared = YXNetwork()
    var tasks : [URLSessionDataTask] = NSMutableArray.init() as! [URLSessionDataTask]
    
    private override init() {
        // 实现初始化代码
    }

    
    func getJokeWithGet(url : String, completion : @escaping (String) -> Void) {
        
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else {
                print("No data returned from API.")
                return
            }
            
            let str = String(data: data, encoding: .utf8)
            
            DispatchQueue.main.async {
                completion(str!)
            }
        }
        task.resume()
        tasks.append(task)
    }
    
    func getJokeWithPost() {
        
        guard let url = URL(string: "https://httpbin.org/post") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
                guard let httpResponse:HTTPURLResponse = response as? HTTPURLResponse else { return }
                debugPrint(httpResponse.statusCode)
                
                guard let data = data else { return }
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    debugPrint(result)
                } catch {
                    debugPrint("解析失败")
                }
        }
        task.resume()
        tasks.append(task)
    }
    
    func cancelRequest() {
        for task : URLSessionTask in tasks {
            task.cancel()
        }
    }
    
    func jsonStringToDictionary(jsonString: String) -> [String: Any]? {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                if let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    return jsonDictionary
                }
            } catch {
                print("JSON serialization failed: \(error)")
            }
        }
        return nil
    }

}
