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
        print("Bienvenue dans le Jeu de Combat le plus pitoyable ! \n")
        
    //Le jeu a deux joueurs dont chacun doit former son équipe
         createPlayer()
        createTeam()
    
    }
    
    //Le joueur choisit le nom de son équipe en s'assurant que ce nom n'est pas encore pris
    private func createPlayer () {
        print("\n\n Joueur \(players.count+1)  A toi de choisir le nom d'équipe:")
        
            if let userInput = readLine() {
                if !userInput.isEmpty {
                    var test = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
                    test = test.uppercased()
                    
                    print(test)
                
            }
                if allPlayers.contains(userInput) {
                    print ("Désolé, ce nom a été déjà choisi")
                } else {
                    let player = Player (name: userInput)
                    players.append(player)
                    print ("Super équipe \(player.name).")
                }
            } else {
                print ("Choisis un nom valide")
                createPlayer()
            }
        
    }
    //Chaque joueur forme son équipe composée de 3 personnages
    private func createTeam () {
        print ("\nForme une équipe de 3 personnages \n")
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
                }
            }
            roundCount += 1
        }
    }
    
    
    
    
    
}
