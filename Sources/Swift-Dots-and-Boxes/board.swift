import Foundation

class Board {
    private var board = [[String]]()

    init() {
        buildBoard()
    }

    private func buildBoard() {
        var current = [String]()
        current.append(" ")
        for i in 65...73 {
            current.append(String(UnicodeScalar(UInt8(i))))
        }
        self.board.append(current)
        for i in 1...9 {
            current.removeAll()
            current.append("\(i)")
            for j in 1...5 {
                if i % 2 != 0 {
                    current.append("\u{2022}")
                } else {
                    current.append(" ")
                }
                if j != 5 {
                current.append(" ")
                }
            }
            self.board.append(current)
        }
    }

    func getBoard() -> [[String]] {
        return self.board
    }

    func showBoard() {
        for i in self.board {
            print("")
            for (index, j) in i.enumerated() {
                print(j, terminator: "")
                if index != 10 {
                    print(" ", terminator: "")
                }
            }
        }
        print("\n")
    }

    func checkAvailable(col: Int, row: Int) {
        print(col, row)
    }

    func updateBoard(row: Int, col: Int) {
        let symbol: String
        if row % 2 == 1 {
            symbol = "\u{2014}"
        } else {
            symbol = "|"
        }
        self.board[row][col] = symbol     
    }

    func addBox(row: Int, col: Int, player: Int) {
        self.board[row][col] = String(player)
    }
}