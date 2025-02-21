<h2>Choose Your Own Adventure Text Game</h2>

<h1>Description</h1>
This is a choose your own adventure game that I built using IOS Swift! It was super fun and has really strengthened my basics in Swift.

**What locations/rooms does your game have?**

1. Mall Entrance
2. Designer Boutique
3. Beauty & Accessories Store
4. Trendy Fashion Outlet
5. Cozy Cafe & Lounge
6. Date Location

**What items does your game have?**

1. VIP Card
2. Mystery Gift
3. Gossip Magazine
4. Elegant Dress
5. Designer Heels
6. Luxury Handbag
7. Diamond Earrings
8. Red Lipstick
9. Designer Sunglasses
10. Casual Chic Outfit
11. Trendy SNeakers
12. Fashionable Backpack
13. Perfume
14. Artisanal Coffee

**Explain how your code is designed. In particular, describe how you used structs or enums, as well as protocols.**

*My game uses enums to define locations (Location) and item types (ItemType), making navigation and item categorization straightforward. A protocol (ItemAction) ensures that all items have a use function, allowing them to affect gameplay dynamically. The structs (Item and YourGame) store item properties and manage the game's state, including inventory, money, and movement between locations.*

**How do you use optionals in your program?**

*Optionals are used in my program to handle cases where a value might be absent. For example, the price property in the Item struct is an Int? because some items, like the VIP Discount Card, do not have a price. When purchasing an item, the program safely unwraps the optional price using if let to check affordability.*

**What extra credit features did you implement, if any?**

* *n/a*

## Endings

### Ending 1: Fashion Icon (Best Ending)
Requirements: Elegant Dress + Designer Heels + Red Lipstick + (Optional: Diamond Earrings / Luxury Handbag)

```
"north" → Enter the Designer Boutique.
"buy elegant dress" → Purchase the best dress.
"buy designer heels" → Get the heels to match.
"south" → Return to the Mall Entrance.
"east" → Enter the Beauty & Accessories Store.
"buy red lipstick" → Essential for confidence.
"buy diamond earrings" → Optional but enhances fashion score.
"south" → Go to the Café & Lounge. (potentially get the vip card)
"north" → Go to the Beauty Store
"west" → Back to the Mall Entrance. (potentially get vip card)
"inventory" → Check items.
"use red lipstick" → Apply before the date.
"south" → Head to the Date Location.
Ending: Your date is impressed, and you become a fashion icon.

```

### Ending 2: "Casual Charm" (Good Ending) - The Safe Choice
Requirements: Casual Chic Outfit + Red Lipstick + (Optional: Sneakers if active date)

```
"west" → Enter the Trendy Fashion Outlet.
"buy casual chic outfit" → A safe but stylish choice.
"buy trendy sneakers" → If planning an active date.
"east" → Back to the Mall Entrance.
"east" → Enter the Beauty & Accessories Store.
"buy red lipstick" → Ensures a confident impression.
"south" → Enter the Café & Lounge.
"buy gossip magazine" → Provides hints on what your date likes.
“use gossip magazine" → Provides hints on what your date likes.
"inventory" → Check items.
"use red lipstick" → Apply before the date.
"north" → Go back to the Beauty Location.
"west" → Head back to the Mall Entrance.
"south" → Head to the Date Location.
Ending: Your date thinks you are stylish and confident.`
``


### Ending 3: "Mysterious & Cool" (Mixed Ending) - A Bold Choice
Requirements: Designer Sunglasses + Luxury Handbag + Casual Outfit

```
"north" → Enter the Designer Boutique.
"buy luxury handbag" → Adds sophistication.
"south" → Back to the Mall Entrance.
"east" → Enter the Beauty & Accessories Store.
"buy designer sunglasses" → Adds a cool and mysterious look.
"west" → Back to Mall
"west" → Enter the Trendy Fashion Outlet.
"buy casual chic outfit" → Keeps the look balanced.
"east" → Back to Mall
"south" → Go to the Date Location.
Ending: Your date is intrigued but unsure about your fashion choices.
```

### Ending 4: "Too Casual" (Bad Ending) - Friend-Zoned
Requirements: Sneakers + Backpack + No Makeup

```
"west" → Enter the Trendy Fashion Outlet.
"buy trendy sneakers" → Prioritizing comfort.
"buy fashionable backpack" → A practical but unromantic choice.
"east" → Enter the Mall Entrance again
"east" → Enter the Beauty Store
"south" → Enter the Café & Lounge.
"buy gossip magazine"+ “use gossip magazine”  → Provides hints but may not help much.
"north" → Go back to Beauty Store
"west" → Go back to Mall Entrance
"south" → Head to the Date Location.
Ending: Your date sees you as casual and friendly, but not romantic.
```


### Ending 5: "Fashion Disaster" (Worst Ending) - Date Ruined
Requirements: Mismatched outfit OR buying nothing

"north" → Enter the Designer Boutique.
"buy elegant dress" → A fancy dress.
"south" → Go back to the Mall Entrance
"west" → Enter the Trendy Fashion Outlet.
"buy trendy sneakers" → Casual shoes with a formal dress.
"east" → Back to Mall Entrance
"east" → Enter the Beauty & Accessories Store.
"buy designer sunglasses" → Mismatched fashion choices.
"west" → Go to Entrance
"south" → Go to Date Location
Ending: Your date is unimpressed and the night is a disaster.

