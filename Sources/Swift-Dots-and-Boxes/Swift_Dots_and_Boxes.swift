import Foundation
@main

public struct Swift_Dots_and_Boxes {

    public static func main() {
        var playAgain = true
        while playAgain {
            let start = Director()
            start.run()
            while true {
                print("Would you like to play again? (Y/N)")
                let answer = readLine()
                if let answer = answer {
                    if answer == "N" || answer == "n" {
                        playAgain = false
                        break
                    } else if answer == "Y" || answer == "y" {
                        break
                    }
                }
                print("Not a valid response")
            }
        }
    }
}