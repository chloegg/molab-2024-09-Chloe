import Foundation

// Function to generate bubbles
func generateBubbles(count: Int) -> [String] {
    var bubbles = [String]()
    for _ in 0..<count {
        let randomSpace = String(repeating: " ", count: Int.random(in: 1...5))
        bubbles.append("\(randomSpace)🫧")
    }
    return bubbles
}

// Function to generate fish of different sizes
func generateFish(count: Int) -> [String] {
    var fishArray = [String]()
    let fishBody = "><(((º>"
    
    for i in 0..<count {
        let spaceBeforeFish = String(repeating: " ", count: i * 2)
        fishArray.append("\(spaceBeforeFish)\(fishBody)")
    }
    return fishArray
}

// Function to print fish and bubbles alternately in a loop
func printFishAndBubbles(fishCount: Int, bubbleCount: Int) {
    let bubbles = generateBubbles(count: bubbleCount)
    let fish = generateFish(count: fishCount)
    
    let maxIterations = max(bubbles.count, fish.count)
    
    for i in 0..<maxIterations {
        if i < bubbles.count {
            print(bubbles[i])
        }
        if i < fish.count {
            print(fish[i])
        }
    }
}

// Variables for fish and bubbles
let numberOfFish = 5
let numberOfBubbles = 4

// Call the function with variables to print the fish and bubbles
printFishAndBubbles(fishCount: numberOfFish, bubbleCount: numberOfBubbles)

