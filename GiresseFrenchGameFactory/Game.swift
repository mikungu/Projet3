//
//  Game.swift
//  GiresseFrenchGameFactory
//
//  Created by Mikungu Giresse on 24/05/22.
//

import Foundation

class Game {
    
    private var roundCount = 0
    
    
    private var players: [Player] = []
    
    
    private var allPlayers : [String] {
        var names: [String] = []
        for player in players {
            names.append(player.name)
        }
        return names
    }
    
   //La première étape consiste à lancer le jeu avec l'affichage du mot de bienvenue
    func startTheGame () {
        print("Bienvenue dans le Jeu de Combat le plus impitoyable ! \n")
        
    //Le jeu a deux joueurs dont chacun doit former son équipe
         createPlayers()
         
    
    }
    
    func createPlayers () {
        while players.count < 2 {
            createPlayer()
            createTeam()
        }
        battleRounds()
        gameOver()
        
    }
    
    //Le joueur choisit le nom de son équipe en s'assurant que ce nom n'est pas encore pris
    private func createPlayer () {
        print("\n\n Joueur \(players.count+1) Comment t'appelles-tu?\n\n")
        
        var validName: Bool = false
        
          while !validName {
            if let userInput = readLine() {
                if !userInput.isEmpty {
                    let finalName = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
                
            
                    if allPlayers.contains(finalName) {
                    print ("Désolé, ce nom est déjà pris, veuillez en choisir un autre")
                    validName = false
                } else {
                    let player = Player (name: finalName)
                    players.append(player)
                    print ("Super \(player.name).")
                    validName = true
                }
              }
        } else {
                print ("Choisis un nom valide")
                validName = false
             }
          }
    }
    //Chaque joueur forme son équipe composée de 3 personnages
    private func createTeam () {
        print ("\nA présent, Forme une équipe de 3 personnages \n")
        for player in players {
            player.createMyTeam()
        }
    
        
    }
    
    //La bataille est lancée en round
    
    private func battleRounds () {
        
        //La bataille sera lancée aussi longtemps que les deux joueurs encore des personnages en vie
        while players [0].deadTeamPersonages == false && players[1].deadTeamPersonages == false {
            print ("\n Allez-y, Round \(roundCount+1) \n")
            for player in players {
                if player.deadTeamPersonages == false {
                    let opponent = players.filter { player.name != $0.name} [0]
                    
                    player.pickFighter()
                    player.chooseAction(enemyTeam: opponent.team)
                }
            }
            roundCount += 1
        }
    }
    
    private func gameOver () {
       declareWinner()
        statsDisplay()
    }
    
    private func declareWinner () {
        print ("\nVoici le Vainqueur de la partie:\n\n")
        if players[0].aliveTeamPersonages.count > players[1].aliveTeamPersonages.count {
            print ("L'Equipe \(players[0].name) remporte la partie")
        } else {
            print ("L'Equipe \(players[1].name) remporte la partie")
        }
    }
    
    private func statsDisplay () {
        print ("\n\nLes stats se présentent comme suit:\n\n")
        print ("Equipe \(players[0].name) VS Equipe \(players[1].name)\n\n")
        print ("Nombre de round: \(roundCount+1)\n\n")
        
        for player in players {
            print ("\n\nStats des personnages de l'équipe \(player.name):\n\n")
            
            print ("\nPersonnages morts:")
            for personage in player.team where personage.lifePoints == 0 {
                personageStats (personage: personage)
            }
            if player.aliveTeamPersonages.count > 0 {
                print ("\nPersonnes en vie:")
                for personage in player.aliveTeamPersonages {
                    personageStats (personage: personage)
                }
            }
            
        }
    }
    
    private func personageStats (personage: Personage) {
        print ("\n \(personage.name):" + "Classe: \(personage.personageType);" + "Points de vie: \(personage.lifePoints)")
    }
    
}
