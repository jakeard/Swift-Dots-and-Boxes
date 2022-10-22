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
        let input = readLine()
            if let coords = input {
            return self.checkCoords.checkErrors(coords: coords, board: board)
         
        } else {
            print("\nYou must provide a valid location\n")
            return (false, 0, 0)
        }
    }

    func getScore() -> Int {
        return self.score
    }

    func addToScore(toAdd: Int) {
        self.score += toAdd
    }
}