import Foundation

class Director {
    private var board = Board()
    private var p1 = Player(playerNum: 1)
    private var p2 = Player(playerNum: 2)
    private var tie = Player(playerNum: 3)

    func run() {
        var turn: Player
        var count = 0
        var success: Bool
        var col: Int
        var row: Int
        let finishScore = 16

        print("\nINSTRUCTIONS:\nEnter coordinates in form: (column)(row)\nExample: A2 or a2\n")
        pause()

        while self.p1.getScore() + self.p2.getScore() != finishScore {
            self.board.showBoard()

            if count % 2 == 0 {
                turn = self.p1
            } else {
                turn = self.p2
            }
            (success, row, col) = turn.getInput(board: self.board)
            if success == false {
                pause()
                continue
            }

            self.board.updateBoard(row: row, col: col)
            let madeBox = addPoints(row: row, col: col, player: turn)
            if madeBox {
                continue
            }

            count += 1
        }
        self.board.showBoard()
        let (win, _) = getWinner()
        let winner: Player
        let loser: Player
        if win == "p1" {
            winner = self.p1
            loser = self.p2
        } else if win == "p2" {
            winner = self.p2
            loser = self.p1
        } else {
            print("Both players tied with a score of 8 points each")
            return
        }
        print("\(winner.playerNum) wins with \(winner.getScore()) points")
        print("\(loser.playerNum) loses with \(loser.getScore()) points\n")
    }

    private func addPoints(row: Int, col: Int, player: Player) -> Bool {
        let pointsToAdd = checkBox(row: row, col: col, player: player.playerNum)
        if pointsToAdd > 0 {
            player.addToScore(toAdd: pointsToAdd)
            return true
        }
        return false
    }

    private func checkBox(row: Int, col: Int, player: Int) -> Int {
        var points = 0
        if row % 2 == 1 {
            points = checkBoxVert(row: row, col: col, player: player)
        } else {
            points = checkBoxHoriz(row: row, col: col, player: player)
        }
        return points
    }
    
    private func checkBoxVert(row: Int, col: Int, player: Int) -> Int {
        var boxes = 0
        if row != 1 {
            if self.board.getBoard()[row - 1][col] == " " && checkLine(row: row - 1, col: col - 1) && checkLine(row: row - 1, col: col + 1) && checkLine(row: row - 2, col: col) {
                boxes += 1
                self.board.addBox(row: row - 1, col: col, player: player)
            }
        }
        if row != 9 {
            if self.board.getBoard()[row + 1][col] == " " && checkLine(row: row + 1, col: col - 1) && checkLine(row: row + 1, col: col + 1) && checkLine(row: row + 2, col: col) {
                boxes += 1
                self.board.addBox(row: row + 1, col: col, player: player)
            }
        }
        return boxes
    }

    private func checkBoxHoriz(row: Int, col: Int, player: Int) -> Int {
        var boxes = 0
        if col != 1 {
            if self.board.getBoard()[row][col - 1] == " " && checkLine(row: row, col: col - 2) && checkLine(row: row - 1, col: col - 1) && checkLine(row: row + 1, col: col - 1) {
                boxes += 1
                self.board.addBox(row: row, col: col - 1, player: player)
            }
        }
        if col != 9 {
            if self.board.getBoard()[row][col + 1] == " " && checkLine(row: row, col: col + 2) && checkLine(row: row - 1, col: col + 1) && checkLine(row: row + 1, col: col + 1) {
                boxes += 1
                self.board.addBox(row: row, col: col + 1, player: player)
            }
        }
        return boxes
    }

    private func checkLine(row: Int, col: Int) -> Bool {
        return self.board.getBoard()[row][col] != " "
    }

    private func getWinner() -> (String, String) {
        if self.p1.getScore() > self.p2.getScore() {
            return ("Player 1", "Player 2")
        } else if self.p2.getScore() > self.p1.getScore() {
            return ("Player 2", "Player 1")
        } else {
            return ("tie", "tie")
        }
    }

    private func pause() {
        let date = Date()
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        var minutes_wait = 0
        var seconds_wait = 0
        while minutes_wait == 0 && seconds_wait < 2 {
            let date_wait = Date()
            let calendar_wait = Calendar.current
            minutes_wait = calendar_wait.component(.minute, from: date_wait) - minutes
            seconds_wait = calendar_wait.component(.second, from: date_wait) - seconds
        }
    }
}
