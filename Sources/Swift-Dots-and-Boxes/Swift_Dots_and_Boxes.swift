import Foundation
@main

public struct Swift_Dots_and_Boxes {

    public static func main() {
        var playAgain = true
        while playAgain {
            let start = Director()
            start.run()
            print("Would you like to play again? (Y/N)")
            let answer = readLine()!
            if answer == "N" || answer == "n" {
                playAgain = false
            }
        }
    }
}