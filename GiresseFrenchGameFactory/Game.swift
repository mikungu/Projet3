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
    
   //The first step is to launch the game with the display of the welcome word
    func startTheGame () {
        print("Bienvenue dans le Jeu de Combat le plus impitoyable ! \n")
        
    //Then we call the createPlayers function to build the teams
         createPlayers()
         
    
    }
    //The game consists of two players and each player is invited to form his team
    func createPlayers () {
        while players.count < 2 {
            createPlayer()
            createTeam()
        }
        //In this function, we call on the other functions: battleRound to start the fight and gameOver to signal that the game has come to an end.
        battleRounds()
        gameOver()
        
    }
    
    //The player chooses the name of his team making sure that this name is not yet taken, otherwise he will be asked to choose another name
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
    //Each player forms his team made up of 3 characters
    private func createTeam () {
        print ("\nA présent, Forme une équipe de 3 personnages \n")
        for player in players {
            player.createMyTeam()
        }
    
        
    }
    
    //The battle takes place in rounds until one of the teams has no more living characters, otherwise we will move on to the next round.
    private func battleRounds () {
        
    //La bataille sera lancée aussi longtemps que les deux joueurs auront encore des personnages en vie
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
    //When the game comes to an end, it will be a question of declaring the winner and displaying the statistics
    private func gameOver () {
       declareWinner()
        statsDisplay()
    }
   //This is to see, at the end of the game, which team still has characters alive, that is to say more than the other
    private func declareWinner () {
        print ("\nVoici le Vainqueur de la partie:\n\n")
        if players[0].aliveTeamPersonages.count > players[1].aliveTeamPersonages.count {
            print ("L'Equipe \(players[0].name) remporte la partie")
        } else {
            print ("L'Equipe \(players[1].name) remporte la partie")
        }
    }
    //At the end of the game, place will be the statistics of each of the respective teams.
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
