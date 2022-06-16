//
//  Player.swift
//  GiresseFrenchGameFactory
//
//  Created by Mikungu Giresse on 24/05/22.
//

import Foundation

class Player {
    
    
    var name: String
    
   //A team consists of an array of three characters
    var team: [Personage] = []
    
    //A team remains alive when the lifePoints of the whole is more than 0
    var aliveTeamPersonages : [Personage] {
        team.filter {$0.lifePoints > 0}
        }
    //A team is eliminated when the lifePoints of the whole equal 0 (empty)
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
    
    //It's about forming a team by choosing three characters listed with a corresponding number
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
    //After choosing a character, it will be a question of finding a unique name for it.
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
    
    //For the fight, each player will pick in his team a character with the corresponding number
    func pickFighter () {
        print ("Equipe \(name), choisis un chiffre correspondant à un personnage avec lequel tu souhaites accomplir une action: \n")
        //He will pick among the living characters
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
    
    
    
    //Then he will indicate the type of action he wants to perform with the character of his chosen team by typing the corresponding number
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
    
    //He will select the character of the opposing team to attack
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
    
    //The attack function consists of taking away the life points of the opponent in relation to the damage caused by his weapon and displaying the remaining life points
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
    
    //He will select the teammate to heal from among the living characters, i.e. whose lifePoints are greater than 0
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
    
    
    //The healing function consists of adding the life points to the teammate in relation to his healSkill and then displaying the total life points
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
    
    
    
    //The player selects the character towards whom his action is intended:
    func pickEnemy () {
        print ("Equipe \(name), choisis un chiffre correspondant à un personnage avec lequel tu souhaites accomplir une action: \n")
        //He chooses among the living characters
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
