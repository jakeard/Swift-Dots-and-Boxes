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
        let resp = readLine()
        // guard let coords = resp! else {
            // print("\nYou must provide a valid location\n")
            // return (false, 0, 0)
        // }
        if resp == nil {
            print("\nYou must provide a valid location\n")
            return (false, 0, 0)
        }
        let coords = resp!
        return self.checkCoords.checkErrors(coords: coords, board: board)
        }

    func getScore() -> Int {
        return self.score
    }

    func addToScore(toAdd: Int) {
        self.score += toAdd
    }
}