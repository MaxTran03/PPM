//
//  QuestionsReponses.swift
//  Quizz
//
//  Created by m2sar on 21/10/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import Foundation

class QuestionsReponses : NSObject{
    typealias myQuizz = (String, String, Bool)
    
    var easyQuizz = [("Question facile 1", "Réponse facile 1", false),
                     ("Question facile 2", "Réponse facile 2", false),
                     ("Question facile 3", "Réponse facile 3", false),
                     ("Question facile 4", "Réponse facile 4", false),
                     ("Question facile 5", "Réponse facile 5", false)]
    
    var hardQuizz = [("Question difficile 1", "Réponse difficile 1", false),
                     ("Question difficile 2", "Réponse difficile 2", false),
                     ("Question difficile 3", "Réponse difficile 3", false),
                     ("Question difficile 4", "Réponse difficile 4", false),
                     ("Question difficile 5", "Réponse difficile 5", false)]
    
}
