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
    
    var fightingPersonage = Personage(name: "")
    
    func createMyTeam () {
        
        let personagesList = [Warrior(), Magus(), Colossus()]
        
        while team.count < 3 {
            
            print("Choisis le personnage numero \(team.count+1) parmi les suivants en tapant le chiffre correspondant !\n")
            
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
                
                print("\n Cool, Ton \(type) se nommera \(userInput)! \n\n")
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
            case "1" :
                if team[0].lifePoints > 0 {
                    chosenFighter(personageNumber: 0)}
            case "2":
                if team[1].lifePoints > 0 {
                    chosenFighter(personageNumber: 1)}
            case "3":
                if team[2].lifePoints > 0 {
                    chosenFighter(personageNumber: 2)}
            default:
                print ("\nTape un chiffre correspondant\n\n")
                pickFighter()
            }
        }
    }
    

private func chosenFighter (personageNumber: Int) {
    fightingPersonage = team [personageNumber]
    print ("\nTu as sélectionné \(fightingPersonage.name)")
}
    
    
    
    //Le joueur indique le type d'action qu'il veut accomplir:
    func chooseAction (enemyTeam: [Personage]) {
        print ("Quelle action veux-tu accomplir?\n"
               + "1. Soigner\n" +
               "2. Attaquer \n\n")
        
        if let choice = readLine() {
            switch choice {
            case "1":
                healChoices()
            case "2":
                attackChoices(enemyTeam: enemyTeam)
            default:
                print ("Merci de choisir une de ces options")
                chooseAction(enemyTeam: enemyTeam)
            }
        }
    }
    
    //Selectionner le pernonnage de l'équipe adverse à attaquer
    func attackChoices (enemyTeam: [Personage]) {
       print ("\n\nChoisis l'ennemi que tu veux attaquer\n\n")
    
        //Il choisit parmi les personnages vivants
        for (index, personage) in enemyTeam.enumerated() {
            if personage.lifePoints > 0 {
                print ("\(index+1). Attaquer \(personage.name) le \(personage.personageType) (\(personage.lifePoints)/\(personage.maxLifePoints) points de vie) \n")
            }
        }
        
            if let choice = readLine() {
            switch choice {
            case "1" :
                if enemyTeam[0].lifePoints > 0 {
                    attack(target: enemyTeam [0])}
            case "2":
                if enemyTeam[1].lifePoints > 0 {
                    attack(target: enemyTeam [1])}
            case "3":
                if enemyTeam[2].lifePoints > 0 {
                    attack(target: enemyTeam [2])}
            default:
                print ("\nTape un chiffre correspondant\n\n")
                attackChoices (enemyTeam: enemyTeam)
            }
        }
    }
    
    //Attaquer
    
    private func attack (target: Personage) {
        
        target.lifePoints -= fightingPersonage.weapon.damage
        print ("\nTon personnage frappe \(target.name) pour \(fightingPersonage.weapon.damage) points de dégats\n\n")
        if target.lifePoints > 0 {
            print ("\(target.name) a desormais \(target.lifePoints)/\(target.maxLifePoints) points de vie\n\n")
        } else {
            print ("\(target.name) n'a plus de points de vie; par conséquent \(target.name) est retiré de l'équipe")
            target.lifePoints = 0
        }
    }
    
    //Selectionner un coéquipier à soigner
    func healChoices () {
        print ("Choisis un coéquipier à soigner\n")
        for (index, personage) in team.enumerated() {
                if personage.lifePoints > 0 {
                    print ("\(index+1). Soigne \(personage.name) ton coéquipier \(personage.personageType) (\(personage.lifePoints)/\(personage.maxLifePoints) points de vie) \n")
                }
            }
            
                if let choice = readLine() {
                switch choice {
                case "1" :
                    if team[0].lifePoints > 0 {
                        heal(personageNumber: 0)}
                case "2":
                    if team[1].lifePoints > 0 {
                        heal(personageNumber: 1)}
                case "3":
                    if team[2].lifePoints > 0 {
                        heal(personageNumber: 2)}
                default:
                    print ("\nTape un chiffre correspondant\n\n")
                    healChoices()
                }
            }
        }
    
    
    //Soigner
    private func heal (personageNumber: Int) {
        let target = team [personageNumber]
        if target.lifePoints <= target.maxLifePoints - fightingPersonage.healthSkill {
            target.lifePoints += fightingPersonage.healthSkill
            print ("\(target.name) récupère \(fightingPersonage.healthSkill) points de vie \(target.name) a desormais \(target.lifePoints) points de vie\n\n")
        } else if target.lifePoints == target.maxLifePoints {
            print ("\n Ce personnage avait déjà le maximum de points de vie. Cela n'a eu aucun effet...\n\n")
        } else {
            print ("\(target.name) récupère \(target.maxLifePoints - target.lifePoints) points de vie")
        }
    }
    
    
    
    //Le joueur selectionne le personnage vers qui son action est destinée:
    func pickEnemy () {
        print ("Equipe \(name), choisis un chiffre correspondant à un personnage avec lequel tu souhaites accomplir une action: \n")
        //Il choisit parmi les personnages vivants
        for (index, personage) in team.enumerated() {
            if personage.lifePoints > 0 {
                print ("\(index+1). \(personage.name) le \(personage.personageType) (\(personage.lifePoints)/\(personage.maxLifePoints) points de vie) \n")
            }
        }
        
            if let choice = readLine() {
            switch choice {
            case "1" :
                if team[0].lifePoints > 0 {
                    chosenFighter(personageNumber: 0)}
            case "2":
                if team[1].lifePoints > 0 {
                    chosenFighter(personageNumber: 1)}
            case "3":
                if team[2].lifePoints > 0 {
                    chosenFighter(personageNumber: 2)}
            default:
                print ("\nTape un chiffre correspondant\n\n")
                pickFighter()
            }
        }
    }
   

    
    
    
    


    
}
