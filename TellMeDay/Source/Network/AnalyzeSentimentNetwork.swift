//
//  AnalyzeSentimentNetwork.swift
//  TellMeDay
//
//  Created by 전준영 on 9/28/24.
//

import Foundation

final class AnalyzeSentimentNetwork {
    
    static let shared = AnalyzeSentimentNetwork()
    private init() { }
    
    func analyzeSentiment(text: String, completion: @escaping ([SentimentData]?, String?) -> Void) {
        let apiKey = APIKey.key
        let url = URL(string: APIURL.baseURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "model": APIModel.model,
            "messages": [
                ["role": "system", "content":
                 "You are an assistant that analyzes sentiment. Return sentiment as 'positive' and 'negative' percentages summing to 100%, and also classify the overall emotion as one of: 'joy', 'sadness', 'anger', 'fear'. Just output in plain English."],
                ["role": "user", "content": text]
            ],
            "temperature": 0.7
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, nil)
                return
            }
            
            if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []),
               let jsonDict = jsonResponse as? [String: Any],
               let choices = jsonDict["choices"] as? [[String: Any]],
               let message = choices.first?["message"] as? [String: Any],
               let sentimentText = message["content"] as? String {
                
                let parsedResult = self.parseSentimentResult(sentimentText)
                let emotion = self.parseEmotion(sentimentText)
                completion(parsedResult, emotion)
                
            } else {
                completion(nil, nil)
            }
        }
        task.resume()
    }
    
    private func parseSentimentResult(_ sentimentText: String) -> [SentimentData] {
        let positiveRegex = try? NSRegularExpression(pattern: "(\\d+)%[^\\n]*positive", options: .caseInsensitive)
        let negativeRegex = try? NSRegularExpression(pattern: "(\\d+)%[^\\n]*negative", options: .caseInsensitive)

        var positivePercentage: Int = 0
        var negativePercentage: Int = 0
        
        if let match = positiveRegex?.firstMatch(in: sentimentText, range: NSRange(sentimentText.startIndex..., in: sentimentText)) {
            if let range = Range(match.range(at: 1), in: sentimentText) {
                positivePercentage = Int(sentimentText[range]) ?? 0
            }
        }
        
        if let match = negativeRegex?.firstMatch(in: sentimentText, range: NSRange(sentimentText.startIndex..., in: sentimentText)) {
            if let range = Range(match.range(at: 1), in: sentimentText) {
                negativePercentage = Int(sentimentText[range]) ?? 0
            }
        }
        
        return [
            SentimentData(emotion: "positive", percentage: Double(positivePercentage)),
            SentimentData(emotion: "negative", percentage: Double(negativePercentage))
        ]
    }
    
    private func parseEmotion(_ sentimentText: String) -> String {
        let emotionRegex = try? NSRegularExpression(pattern: "(joy|sadness|fear|anger)")
        
        if let match = emotionRegex?.firstMatch(in: sentimentText, range: NSRange(sentimentText.startIndex..., in: sentimentText)) {
            if let range = Range(match.range(at: 1), in: sentimentText) {
                return String(sentimentText[range])
            }
        }
        
        return "분석 실패"
    }
}
