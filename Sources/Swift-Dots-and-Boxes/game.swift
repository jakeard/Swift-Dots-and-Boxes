import Foundation

class Director {
    private var board = Board()
    private var p1 = Player(playerNum: 1)
    private var p2 = Player(playerNum: 2)

    func run() {
        var turn: Player
        var count = 0
        var success: Bool
        var col: Int
        var row: Int
        let finishScore = 16

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
        let (winner, loser) = getWinner()

        print("Player \(winner.playerNum) wins with \(winner.getScore()) points")
        print("Player \(loser.playerNum) loses with \(loser.getScore()) points\n")
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

    private func getWinner() -> (Player, Player) {
        if self.p1.getScore() > self.p2.getScore() {
            return (self.p1, self.p2)
        } else {
            return (self.p2, self.p1)
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
