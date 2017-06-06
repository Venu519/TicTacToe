//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Venugopal Reddy Devarapally on 05/06/17.
//  Copyright © 2017 venu. All rights reserved.
//

import UIKit
private let gameReuseIdentifier = "gameReuseIdentifier"



class GameViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    enum Planet: Int {
        case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    }
    
    struct Player {
        var playerName = ""
        var playerId = 1
        var isHisTurn = false
        var didHeWin = false
        var positions:[IndexPath] = []
    }
    
    var gameNumber: CGFloat = 3
    var player1 = Player()
    var player2 = Player()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gameCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initial Setup
        if player1.playerName == "" {
            player1.playerName = "Player 1"
        }
        player1.isHisTurn = true
        titleLabel.text = player1.playerName+"'s Turn"
        player1.playerId = 1
        
        if player2.playerName == "" {
            player2.playerName = "Player 2"
        }
        player2.isHisTurn = false
        player2.playerId = 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.collectionViewLayout = flowLayout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Int(gameNumber)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(gameNumber)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell  = gameCollectionView.dequeueReusableCell(withReuseIdentifier: gameReuseIdentifier, for: indexPath) as! GameCollectionViewCell
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.white.cgColor
        cell.cellLabel.text = ""
        cell.playerId = 0
        
        let bottomOffset = CGPoint(x: 0, y: gameCollectionView.contentSize.height - gameCollectionView.bounds.size.height)
        gameCollectionView.setContentOffset(bottomOffset, animated: false)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GameCollectionViewCell
        if cell.cellLabel.text == "" {
            if player1.isHisTurn {
                cell.cellLabel.text = "O"
                cell.cellLabel.font = UIFont.systemFont(ofSize: cell.cellLabel.bounds.size.height)
                cell.playerId = player1.playerId
                player1.positions.append(indexPath)
                player1.isHisTurn = false
                player2.isHisTurn = true
            }else{
                cell.cellLabel.text = "X"
                cell.cellLabel.font = UIFont.systemFont(ofSize: cell.cellLabel.bounds.size.height)
                player2.positions.append(indexPath)
                player2.isHisTurn = false
                player1.isHisTurn = true
                cell.playerId = player2.playerId
            }
            checkResultForCollectionView(collectionVW: collectionView)
            updateView()
        }
        if player1.positions.count + player2.positions.count ==  Int(gameNumber)*Int(gameNumber){
            if !player1.didHeWin && !player2.didHeWin{
                showAlertViewWith(message: "It's a Tie")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 10) / gameNumber, height: (collectionView.bounds.size.height - 10) / gameNumber)
    }
    
    func updateView(){
        if player1.didHeWin {
            showAlertViewWith(message: player1.playerName+" Won!!")
        }else if player2.didHeWin {
            showAlertViewWith(message: player2.playerName+" Won!!")
        }else{
            if player1.isHisTurn {
                titleLabel.text = player1.playerName+"'s Turn"
            }else{
                titleLabel.text = player2.playerName+"'s Turn"
            }
        }
    }
    
    func checkResultForCollectionView(collectionVW: UICollectionView){
        var resultP1 = true
        var resultP2 = true
        
        //Horizontal Check
        for column in 0...Int(gameNumber-1){
            for row in 0...Int(gameNumber-1) {
                let cell = collectionVW.cellForItem(at: IndexPath.init(row: row, section: column)) as! GameCollectionViewCell
                if cell.playerId != player1.playerId{
                    resultP1 = false
                }
                if cell.playerId != player2.playerId{
                    resultP2 = false
                }
            }
            if resultP1{
                player1.didHeWin = true
                return
            }else if resultP2{
                player2.didHeWin = true
                return
            }else{
                resultP1 = true
                resultP2 = true
            }
        }

        //Vertical Check
        for row in 0...Int(gameNumber-1){
            for column in 0...Int(gameNumber-1) {
                let cell = collectionVW.cellForItem(at: IndexPath.init(row: row, section: column)) as! GameCollectionViewCell
                if cell.playerId != player1.playerId{
                    resultP1 = false
                }
                if cell.playerId != player2.playerId{
                    resultP2 = false
                }
            }
            if resultP1{
                player1.didHeWin = true
                return
            }else if resultP2{
                player2.didHeWin = true
                return
            }else{
                resultP1 = true
                resultP2 = true
            }
        }
        
        //Right Diagonal Check
        for row in 0...Int(gameNumber-1){
            let cell = collectionVW.cellForItem(at: IndexPath.init(row: row, section: row)) as! GameCollectionViewCell
            if cell.playerId != player1.playerId{
                resultP1 = false
            }
            if cell.playerId != player2.playerId{
                resultP2 = false
            }
        }
        if resultP1{
            player1.didHeWin = true
            return
        }else if resultP2{
            player2.didHeWin = true
            return
        }else{
            resultP1 = true
            resultP2 = true
        }
        
        //Left Diagonal Check
        for row in 0...Int(gameNumber-1){
            let cell = collectionVW.cellForItem(at: IndexPath.init(row: row, section: Int(gameNumber-1) - row)) as! GameCollectionViewCell
            if cell.playerId != player1.playerId{
                resultP1 = false
            }
            if cell.playerId != player2.playerId{
                resultP2 = false
            }
        }
        if resultP1{
            player1.didHeWin = true
            return
        }else if resultP2{
            player2.didHeWin = true
            return
        }else{
            resultP1 = true
            resultP2 = true
        }
    }
    
    func showAlertViewWith(message: String){
        let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
            self.reloadGame()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func reloadGame(){
        player1.isHisTurn = true
        player1.didHeWin = false
        player1.positions = []
        
        player2.isHisTurn = false
        player2.didHeWin = false
        player2.positions = []
        updateView()
        gameCollectionView.reloadData()
    }
}
