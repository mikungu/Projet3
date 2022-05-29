//
//  Player.swift
//  GiresseFrenchGameFactory
//
//  Created by Mikungu Giresse on 24/05/22.
//

import Foundation

class Player {
    
    
    var name: String
    
   //Une équipe est composée d'un tableau de trois personnages
    var team: [Personage] = []
    
    //Une équipe reste en vie lorsque les points de vie de l'ensemble est supérieure à 0
    var aliveTeamPersonages : [Personage] {
        team.filter {$0.lifePoints > 0}
        }
    //Une équipe est éliminée quand les points de vie de l'ensemble égale à 0 (vide)
    var deadTeamPersonages : Bool {
        if aliveTeamPersonages.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    init(name: String) {
        self.name=name
    }
    
    private var fightingPersonage = Personage(name: "")
    
    func createMyTeam () {
        
        let personagesList = [Warrior(), Magus(), Colossus()]
        
        while team.count < 3 {
            
            print("Choisis le personnage numero \(team.count+1) parmi les suivants !\n")
            
            for personage in personagesList {
                print("\(personage.description)")
            }
            
        let choice = readLine()
            switch choice {
            case "1":
                team.append(Warrior())
                chooseName (of: "Guerrier")
            case "2":
                team.append(Magus())
                chooseName(of: "Mage")
            case "3":
                team.append(Colossus())
                chooseName(of: "Colosse")
            default: print("ou tape au numero correspondant du joueur entre 1 et 3")
            }

        }
        
        
    }
    
    func chooseName (of type: String) {
        print("\n Tu as opté pour \(type) trouve-lui un nom")
        
        if let userInput = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !userInput.isEmpty {
            if Personage.personagesNames.contains(userInput) {
                print("Désolé, ce nom est déjà pris.")
                chooseName(of: type)
            } else {
                Personage.personagesNames.append(userInput)
                
                team[team.count-1].name = userInput
                
                print("\n Toi le tout dernier, Ton \(type) se nommera \(userInput)! \n\n")
            }
        } else {
            print("Choisis un nom valide")
            chooseName(of: type)
        }
    }
    
    //Le joueur choisit dans son équipe un personnage
    func pickFighter () {
        print ("Equipe \(name), choisis un chiffre correspondant à un personnage avec lequel tu souhaites accomplir une action: \n")
        //Il choisit parmi les personnages vivants
        for (index, personage) in team.enumerated() {
            if personage.lifePoints > 0 {
                print ("\(index+1). \(personage.name) le \(personage.personageType) (\(personage.lifePoints)/\(personage.maxLifePoints) points de vie) \n")
            }
        }
        
        if let choice = readLine() {
            switch choice {
            case "1" where team[0].lifePoints > 0 :
                
            case "2" where team[1].lifePoints > 0 :
                
            case "3" where team[2].lifePoints > 0 :
                
            default:
                
            }
        }
    }
    
    
    
    
    //Le joueur indique le type d'action qu'il veut accomplir:
    //Attaquer
    
    
    
    
    //Soigner
    
    
    
    
    //Le joueur selectionne le personnage vers qui son action est destinée:
    //Personnage à attaquer
    
    
    
    
    //Personnage à soigner

    
}
