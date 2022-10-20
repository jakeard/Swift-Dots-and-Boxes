import Foundation

class Player {
    let playerNum: Int
    private var score = 0
    private var checkCoords = CheckValidCoords()

    init(playerNum: Int) {
        self.playerNum = playerNum    
    }

    func getInput(board: Board) -> (Bool, Int, Int) {
        print("Player \(self.playerNum) turn: ", terminator: "")
        let coords = readLine()!
        return self.checkCoords.checkErrors(coords: coords, board: board)
    }

    func getScore() -> Int {
        return self.score
    }

    func addToScore(toAdd: Int) {
        self.score += toAdd
    }
}