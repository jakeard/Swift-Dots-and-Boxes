import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

class CheckValidCoords {
    func checkErrors(coords: String, board: Board) -> (Bool, Int, Int) {
        if coords.count != 2 {
            return giveError()
        }
        let results = checkValid(board: board, coords: coords)
        if results.0 == false {
            return (false, 0, 0)
        }
        return results
    }

    private func checkValid(board: Board, coords: String) -> (Bool, Int, Int) {
        if coords[0].isLetter == false || coords[1].isNumber == false {
            return giveError()
        }

        let letter = Int(Character(coords[0].uppercased()).asciiValue!) % 64
        let num = Int(String(coords[1]))!

        if letter > 9 || num == 0 {
            return giveError()
        }
        if board.getBoard()[num][letter] != " " || (num % 2 == 0 && letter % 2 == 0) {
            return giveError()
        }
        return (true, num, letter)
    }

    private func giveError() -> (Bool, Int, Int) {
        print("\nYou must provide a valid location\n")
        return (false, 0, 0)
    }
}