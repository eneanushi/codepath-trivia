import Foundation

class TriviaQuestionService {
    
    static func fetchTrivia(
    category: String,
    amount:String,
    difficulty:String,
    type: String,
    completion: (([TriviaQuestion]) -> Void)? = nil
        
    ){
        
        let parameters = "amount=\(amount)&category=\(category)&difficulty=\(difficulty)&type=\(type)"
        
        let urlString = "https://opentdb.com/api.php?\(parameters)"
        
        let url = URL(string:urlString)!
        
        let task = URLSession.shared.dataTask(with: url){data,response, error in
            
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            
            let questions = parse(data:data)
            DispatchQueue.main.async{
                completion?(questions)
            }
        }
            
            task.resume()
    }
        
        private static func parse(data: Data) -> [TriviaQuestion]{
             
            let jsonDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            let decoder = JSONDecoder()
            let main_response = try! decoder.decode(TriviaResponse.self, from: data)

            
            let parsed_data = main_response.results
            return parsed_data
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


