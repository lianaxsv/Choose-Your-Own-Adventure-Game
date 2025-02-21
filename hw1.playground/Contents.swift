import Foundation

// TODO: Declare any additional structs, classes, enums, or protocols here!


enum Location {
    case mallEntrance, designerBoutique, beautyStore, trendyOutlet, cafeLounge, dateLocation
    
    var description: String {
        switch self {
        case .mallEntrance:
            return "You are at the grand entrance of Glamour Galleria, the most luxurious shopping mall in town. Various stores are around you, and the excitement is in the air. You have a date later tonight, and you want to impress them with your fashion sense. Choose the best outfit you can. Make sure to not accidentally go to the date location (south of mall entrance) before you're done shopping! Good luck"
        case .designerBoutique:
            return "Welcome to the Designer Boutique! The finest dresses, heels, and handbags are here, but they come with a hefty price tag."
        case .beautyStore:
            return "You enter the Beauty & Accessories Store. Rows of lipsticks, perfumes, and accessories line the walls, all promising to make you stand out."
        case .trendyOutlet:
            return "The Trendy Fashion Outlet is filled with affordable, stylish pieces. This is the perfect place to grab something fun yet budget-friendly."
        case .cafeLounge:
            return "You step into the cozy Café & Lounge. It's the perfect place to relax, and you overhear some useful fashion gossip while sipping coffee."
        case .dateLocation:
            return "It's time! You've arrived at the date location. Will your outfit impress, or will this night be a fashion disaster?"
        }
    }
}

// Struct for the 5 locations

struct Locations {
    let name: String
    let description: String
    let exits: [String]
    let items: [Item]
}

enum ItemType {
    case clothing, accessory, beauty, discount, magazine, food, utility
}

protocol ItemAction {
    func use(game: inout YourGame, context: AdventureGameContext)
}

struct Item: ItemAction {
    let name: String
    let description: String
    let price: Int?
    let type: ItemType

    func use(game: inout YourGame, context: AdventureGameContext) {
        switch type {
        case .discount:
            game.hasFoundVIPCard = true
            context.write("You used the VIP Discount Card! All future purchases are now 20% off.")
        case .clothing, .accessory:
            context.write("You admire your \(name). It’s a great addition to your outfit!")
        case .beauty:
            context.write("You applied \(name). It makes you feel more confident!")
        case .food:
            context.write("You enjoy your \(name). Delicious!")
        case .magazine:
            context.write("📰 You flip through the Gossip Magazine and find a section on your date's fashion preferences. It says that he dislikes overly casual outfits but loves well-coordinated styles, whether expensive or affordable.")
        default:
            context.write("\(name) cannot be used right now.")
        }
    }
}


// special items- for utility and discounts
let vipCard = Item(
    name: "VIP Discount Card",
    description: "Gives you 20% off at all stores!",
    price: nil,
    type: .discount
)

let mysteryGift = Item(
    name: "Mystery Gift Box",
    description: "A surprise purchase! You don’t know what’s inside until you open it.",
    price: 50,
    type: .utility
)


let gossipMagazine = Item(
    name: "Gossip Magazine",
    description: "Contains fashion tips and hints about what your date likes!",
    price: 10,
    type: .magazine
)


//designer boutique items
let elegantDress = Item(
    name: "Elegant Dress",
    description: "A high-end evening dress perfect for a romantic date night.",
    price: 180,
    type: .clothing
)

let designerHeels = Item(
    name: "Designer Heels",
    description: "A pair of stunning Louboutin heels that add elegance to any outfit.",
    price: 100,
    type: .accessory
)

let luxuryHandbag = Item(
    name: "Luxury Handbag",
    description: "A stunning Dior handbag that completes your outfit.",
    price: 200,
    type: .accessory
)


//beauty + accessories store
let diamondEarrings = Item(
    name: "Diamond Earrings",
    description: "Sparkling Tiffany earrings that add a touch of luxury.",
    price: 40,
    type: .accessory
)

let redLipstick = Item(
    name: "Red Lipstick",
    description: "A bold red lipstick that enhances your confidence. Make sure to use it before the date!",
    price: 25,
    type: .beauty
)

let designerSunglasses = Item(
    name: "Designer Sunglasses",
    description: "Chic Prada sunglasses that make you look effortlessly cool.",
    price: 35,
    type: .accessory
)



//trendy fashion outlet
let casualChicOutfit = Item(
    name: "Casual Chic Outfit",
    description: "A trendy yet laid-back outfit, perfect for a casual date.",
    price: 45,
    type: .clothing
)

let trendySneakers = Item(
    name: "Trendy Sneakers",
    description: "A pair of stylish sneakers that add a sporty, effortless vibe.",
    price: 30,
    type: .accessory
)

let fashionableBackpack = Item(
    name: "Fashionable Backpack",
    description: "A practical yet stylish backpack, great for casual outings.",
    price: 20,
    type: .accessory
)


//cafe and lounge
let perfume = Item(
    name: "Luxury Perfume",
    description: "A soft floral scent that makes a lasting impression.",
    price: 55,
    type: .beauty
)

let artisanalCoffee = Item(
    name: "Artisanal Coffee",
    description: "A fancy latte from the café that boosts your energy for shopping!",
    price: 8,
    type: .utility
)





/// Declare your game's behavior and state in this struct.
///
/// This struct will be re-created when the game resets. All game state should
/// be stored in this struct.
struct YourGame: AdventureGame {
    /// Returns a title to be displayed at the top of the game.
    ///
    /// You can generate this dynamically based on your game's state.
    var title: String {
        // TODO: Change this title
        return "The Ultimate Date Shopping Spree 🛍️✨"
    }
    
    var currentLocation: Location = .mallEntrance
    var money: Int = 400
    var inventory: [Item] = []
    var hasFoundVIPCard: Bool = false
    
    let mallMap: [Location: [String: Location]] = [
        .mallEntrance: ["north": .designerBoutique, "east": .beautyStore, "west": .trendyOutlet, "south": .dateLocation],
        .designerBoutique: ["south": .mallEntrance], .beautyStore: ["west": .mallEntrance, "south": .cafeLounge],.trendyOutlet: ["east": .mallEntrance],
        .cafeLounge: ["north": .beautyStore]
      ]


    /// Runs at the start of every game.
    ///
    /// Use this function to introduce the game to the player.
    ///
    /// - Parameter context: The object you use to write output and end the game.
    mutating func start(context: AdventureGameContext) {
        // TODO: Remove this and implement logic to start your game!
        playIntroduction()
        context.write("Welcome to Glamour Galleria! Your goal is to find the perfect outfit for your date tonight.")
        context.write(currentLocation.description)
        context.write("You have $\(money). Where would you like to go?")
    }
    
    /// Runs when the user enters a line of input.
    ///
    /// Generally, you parse the user's command, update game state as necessary, then
    /// write output.
    ///
    /// To display a line to the user, use the `context.write(_)` function and pass in
    /// a ``String``, like this:
    ///
    /// ```swift
    /// context.write("You have been eaten by a grue.")
    /// ```
    ///
    /// If you'd like to end the game (say, if the player dies), call context.endGame().
    /// Note that this does *not* display a game over message - it merely disables
    /// the buttons and forces the user to reset.
    ///
    /// - Parameters:
    ///   - input: The line the user typed.
    ///   - context: The object you use to write output and end the game.
    mutating func handle(input: String, context: AdventureGameContext) {
        let words = input.lowercased().split(separator: " ")
        guard let commandSubstring = words.first else {
            context.write("Invalid command.")
            return
        }

        let command = String(commandSubstring)

        switch command {
        case "north", "south", "east", "west":
            move(direction: command, context: context)
        case "buy":
            if words.count < 2 {
                context.write("Buy what?")
            } else {
                let itemName = String(words.dropFirst().joined(separator: " "))
                buyItem(named: itemName, context: context)
            }
        case "pick", "pick up":
            if words.count < 2 {
                context.write("Pick up what?")
            } else {
                let itemName = String(words.dropFirst().joined(separator: " "))
                pickUpItem(named: itemName, context: context)
            }
        case "use":
            if words.count < 2 {
                context.write("Use what?")
            } else {
                let itemName = String(words.dropFirst().joined(separator: " "))
                useItem(named: itemName, context: context)
            }
        case "inventory":
            listInventory(context: context)
        case "help":
            context.write("Available commands: north, south, east, west, buy [item], pick up [item], use [item], inventory, check budget.")
        case "view":
               if words.count > 1 && words[1] == "items" {
                   viewItems(context: context)
               } else {
                   context.write("Unknown 'view' command. Try 'view items'.")
               }
        case "check":
            if words.count > 1 && words[1] == "budget" {
                context.write("You have $\(money) left.")
            }
        default:
            context.write("Unknown command.")
        }
    }
    
    


    mutating func move(direction: String, context: AdventureGameContext) {
        if let newLocation = mallMap[currentLocation]?[direction] {
            currentLocation = newLocation
            context.write(currentLocation.description)
            
            if (currentLocation == .mallEntrance || currentLocation == .cafeLounge) && !hasFoundVIPCard {
                       let chance = Int.random(in: 1...100)  // Generate a number between 1-100
                       if chance <= 30 {  // 30% chance to find the VIP Card
                           hasFoundVIPCard = true
                           inventory.append(vipCard)
                           context.write("🎉 You found a **VIP Discount Card**! Now, all purchases will have a 20% discount.")
                       }
                   }
            
            if currentLocation == .dateLocation {
                checkOutfitAndEndGame(context: context)
            }
        } else {
            context.write("You can't go that way.")
        }
    }

    mutating func useItem(named itemName: String, context: AdventureGameContext) {
        if let item = inventory.first(where: { $0.name.lowercased() == itemName }) {
            item.use(game: &self, context: context)
        } else {
            context.write("You don’t have \(itemName) in your inventory.")
        }
    }

    mutating func pickUpItem(named itemName: String, context: AdventureGameContext) {
        let allItems = [vipCard, mysteryGift, gossipMagazine, elegantDress, designerHeels, luxuryHandbag,
                        casualChicOutfit, trendySneakers, fashionableBackpack, redLipstick, diamondEarrings,
                        designerSunglasses, perfume, artisanalCoffee]

        if let item = allItems.first(where: { $0.name.lowercased() == itemName }) {
            inventory.append(item)
            context.write("You picked up \(item.name).")
        } else {
            context.write("That item is not available to pick up.")
        }
    }

    
    mutating func buyItem(named itemName: String, context: AdventureGameContext) {
        let allItems = [elegantDress, designerHeels, luxuryHandbag, casualChicOutfit, trendySneakers, fashionableBackpack, redLipstick, diamondEarrings, designerSunglasses, perfume, artisanalCoffee, mysteryGift, gossipMagazine]
        
        if let item = allItems.first(where: { $0.name.lowercased() == itemName }) {
            let finalPrice = hasFoundVIPCard ? Int(Double(item.price ?? 0) * 0.8) : item.price
            
            if let price = finalPrice, money >= price {
                money -= price
                inventory.append(item)
                context.write("You bought \(item.name) for $\(price).")
            } else {
                context.write("You can't afford that.")
            }
        } else {
            context.write("That item is not available here.")
        }
    }

    mutating func listInventory(context: AdventureGameContext) {
           if inventory.isEmpty {
               context.write("Your shopping bag is empty.")
           } else {
               context.write("You are carrying: " + inventory.map { $0.name }.joined(separator: ", "))
           }
       }
    
    
    mutating func viewItems(context: AdventureGameContext) {
        var availableItems: [Item] = []
        
        switch currentLocation {
        case .mallEntrance:
            availableItems = [gossipMagazine]
        case .designerBoutique:
            availableItems = [elegantDress, designerHeels, luxuryHandbag]
        case .beautyStore:
            availableItems = [diamondEarrings, redLipstick, designerSunglasses, perfume]
        case .trendyOutlet:
            availableItems = [casualChicOutfit, trendySneakers, fashionableBackpack]
        case .cafeLounge:
            availableItems = [artisanalCoffee, gossipMagazine]
        default:
            context.write("There are no items to buy here.")
            return
        }
        
        if availableItems.isEmpty {
            context.write("There are no items to buy here.")
        } else {
            context.write("Items available at this location:")
            for item in availableItems {
                if let price = item.price {
                    context.write("- \(item.name): $\(price) | \(item.description)")
                } else {
                    context.write("- \(item.name): Special item | \(item.description)")
                }
            }
        }
    }
    
    
    mutating func checkOutfitAndEndGame(context: AdventureGameContext) {
        var hasElegantDress = false
        var hasCasualChicOutfit = false
        var hasDesignerHeels = false
        var hasLuxuryHandbag = false
        var hasDiamondEarrings = false
        var hasRedLipstick = false
        var hasTrendySneakers = false
        var hasDesignerSunglasses = false

        for item in inventory {
            switch item.name {
            case "Elegant Dress":
                hasElegantDress = true
            case "Casual Chic Outfit":
                hasCasualChicOutfit = true
            case "Designer Heels":
                hasDesignerHeels = true
            case "Luxury Handbag":
                hasLuxuryHandbag = true
            case "Diamond Earrings":
                hasDiamondEarrings = true
            case "Red Lipstick":
                hasRedLipstick = true
            case "Trendy Sneakers":
                hasTrendySneakers = true
            case "Designer Sunglasses":
                hasDesignerSunglasses = true
            default:
                break
            }
        }

        if hasElegantDress && hasDesignerHeels && hasRedLipstick && hasDiamondEarrings {
            context.write("You arrive at your date looking absolutely stunning! The combination of your elegant dress, heels, earrings, and perfectly applied lipstick makes a lasting impression. Your date is mesmerized, and you receive compliments from everyone around. This is a perfect night. (Fashion Icon Ending)")
        } else if hasCasualChicOutfit && hasRedLipstick {
            context.write("Your outfit is stylish and laid-back. Your date appreciates your effortless look and enjoys the evening with you. You might not be the most glamorous person in the room, but you’re confident, and that’s what really matters. (Casual Charm Ending)")
        } else if hasDesignerSunglasses && hasLuxuryHandbag && hasCasualChicOutfit {
            context.write("You arrive at the date looking cool and mysterious, but maybe a little too detached. Your date is intrigued but feels like you’re hard to read. The night goes well, but they leave wondering if they really got to know you. (Mysterious & Cool Ending)")
        } else if hasTrendySneakers && !hasElegantDress {
            context.write("You show up in sneakers and a casual outfit. While you look comfortable, your date was expecting something a little more elegant. The night feels more like hanging out as friends than a romantic date. (Too Casual Ending)")
        } else {
            context.write("You didn’t put together a cohesive outfit. Your date arrives and tries to stay polite, but it’s clear they’re not impressed. The night ends early, and you regret not choosing better fashion pieces. (Fashion Disaster Ending)")
        }

        context.endGame()  // Ends the game
    }

}

// Leave this line in - this line sets up the UI you see on the right.
// Update this if you rename your AdventureGame implementation.
YourGame.run()
