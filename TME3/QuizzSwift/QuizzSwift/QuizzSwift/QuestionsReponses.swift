//
//  QuestionsReponses.swift
//  QuizzSwift
//
//  Created by m2sar on 17/10/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import Foundation

class QuestionsReponses : NSObject{
    typealias myQuizz = (String, String, Bool)
    
    // Array of easy Query/Response
    var easyQuizz = [("Qui est l'auteur de la fable 'Le Corbeau et le Renard' ?", "Jean de la Fontaine", false),
                     ("Comment dit-on 'Bienvenue' en anglais", "Welcome", false),
                     ("Où se trouve le Big Ben ?", "Au Royaume-Uni", false),
                     ("Quel est l'ingrédient principal des blancs en neige ?", "Des oeufs", false),
                     ("Quel est le livre le plus publié au monde ?", "La Bible", false)]
    
    // Array of hard Query/Response
    var hardQuizz = [("Combien pèse une fraise tagada Haribo ?", "5,39 grammes", false),
                     ("Quelle est la formule chimique de la testostérone ?", "C19H28O2", false),
                     ("Le prénom de César était ?", "Caïus", false),
                     ("Que signifie S.O.S", "Rien, ce n'est qu'une série de lettres simples à retenir en morse", false),
                     ("Depuis quelle année passe-t-on à l'heure d'été ?", "1976", false)]
    
}
