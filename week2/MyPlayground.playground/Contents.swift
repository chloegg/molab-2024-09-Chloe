import Foundation

// Function to load an ASCII art file
func load(_ file: String) -> String {
    let path = Bundle.main.path(forResource: file, ofType: nil)
    let str = try? String(contentsOfFile: path!, encoding: .utf8)
    return str ?? "File not found!"
}

// Function to display the available options
func showMenu() {
    print("""
    Choose an animal to visit at the zoo:
    1. Dolphin
    2. Ducks
    3. Owl House
    4. Rabbit
    """)
}

// Simulated user input for Playground environment
let simulatedInput = "1" // Change this to "1", "2", "3", or "4" to test different inputs

// Function to get user's choice and display the corresponding ASCII art
func chooseArt() {
    showMenu()
    
    print("Your choice (1-4): \(simulatedInput)")
    if let choice = Int(simulatedInput) {
        let art: String
        
        switch choice {
        case 1:
            art = load("dolphin.txt")
        case 2:
            art = load("ducks.txt")
        case 3:
            art = load("owl_house.txt")
        case 4:
            art = load("rabbit.txt")
        default:
            art = "Invalid choice! Please select a number between 1 and 4."
        }
        
        print("\nHere’s the animal you're visiting!:\n")
        print(art)
    } else {
        print("Invalid input! Please enter a number between 1 and 4.")
    }
}

// Run the program to choose and display ASCII art
chooseArt()
