//
//  FirebaseManager.swift
//  Moment
//
//  Created by Gleb on 31.03.2024.
//

import UIKit
import FirebaseDatabase
import FirebaseDatabaseSwift
import Firebase

class FirebaseManager {
    
    
    
    static let shared = FirebaseManager()
    private let ref = Database.database(url: "https://moment-5bf7b-default-rtdb.firebaseio.com").reference().child("Questions")
    
    
    
    func getQuestions(completion: @escaping ([QuestionModel]) -> Void) {
            ref.observeSingleEvent(of: .value) { snapshot in
                guard let questionsData = snapshot.value as? [[String: String]] else {
                    completion([])
                    return
                }
                let questions = self.parseQuestions(questionsData)
                completion(questions)
            }
        }
    
    private func parseQuestions(_ questionsData: [[String: String]]) -> [QuestionModel]  {
        var questions: [QuestionModel] = []
        for questionData in questionsData {
            guard let questionText = questionData["Question"],
                  let category = questionData["Category"],
                  let isPremium = questionData["Premium"] else { continue }
            let question = QuestionModel(Question: questionText, Category: category, Premium: isPremium)
            questions.append(question)
        }
        print("✅ВОПРОСЫ СКАЧАНЫ")
        return questions
    }
}


