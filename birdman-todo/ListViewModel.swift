import Foundation

class ListViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    
    init() {
        Task {
            await getWord()            
        }
    }
    
    func getWord() async {
        let url = URL(string: "http://localhost:8080/todos")
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                guard let decodedResponse = try? decoder.decode([Todo].self, from: data) else {
                    print("error")
                    return
                }
                DispatchQueue.main.async {
                    self.todos = decodedResponse
                }
            } else {
                print("error fetch faild")
            }
        }.resume()
    }
    
    func post(text: String) async {
        let url = URL(string: "http://localhost:8080/todos")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postData: [String: String] = ["text": text]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: postData, options: [])
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print("Response status code: \(httpResponse.statusCode)")
                }
                if let data = data {
                    // レスポンスデータを処理する場合
                    if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) {
                        print("Response JSON: \(jsonResponse)")
                    }
                }
            }.resume()  // タスクを開始します
        } catch {
            print("Error encoding JSON: \(error)")
        }
    }
    
    func delete(id: Int) async {
        let urlString = "http://localhost:8080/todos/\(id)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
            }
            if let data = data {
                // レスポンスデータを処理する場合
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print("Response JSON: \(jsonResponse)")
                }
            }
        }.resume()  // タスクを開始します
    }
}
