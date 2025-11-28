# Arena Implementation

Blazing Deserts+ overhauls the vanilla arena system. This was done for a few key reasons:
- First and foremost, I felt the existing system had significant unrealized narrative potential. Match fixing, trash talking, and backroom dealings are all the sorts of hooks I'd expect around an organized fighting ring, but vanilla's single contract doesn't really offer this.
- The uncertainty of what fights are available - and the lack of flexibility from one fight to the next - limit how the arena can be incorporated into the overall strategic layer.
- The arena collar item is a clunky way of choosing which brothers take part in a fight.
- Arena fights are very all or nothing, so you aren't encouraged to take risks like entering fights with less than the max allowed bros, fighting against champions, or take in bros that might die.

In its place, I've developed a more extensible system that I feel addresses - or at least is equipped to address - the above.

The top level construct is, of course, the `arena`. This represents the arena in a specific settlement, and retains its own list of available fights and match stats. Suppose you're creating a mod and you want to add an event that makes a certain item available as a reward in the next fight. You could find the nearest `arena` and call `getAdditionalLoot()` to access and modify a bonus loot table granted on victory - this is how the arena replicates the vanilla handout of gladiator gear via `updateAdditionalLoot`. Alternatively, suppose you're adding a new "Civil Unrest" settlement situation that reduces the available arena options. In that situation's code you could access the `arena` for the current settlement, `getCompositions()` to get the current list of fights, and `removeComposition` with random ones' IDs until the list is sufficiently small.

To access an arena, an `arena_manager` has been added, accessible via `World.Arena`, which provides helpers like `getArenaByCityStateID` and `getCurrentArena`. As you might have inferred, this does mean the system supports more than one arena being present in the world, and each arena can track its own progress, be affected by its own settlement's situations, and so on.

The key construct one level down is the `arena_composition`. This defines the various attributes for a given fight, such as the base pay, the number of allowed entrants, the entities that can spawn as part of the fight, and so on. Compositions have their own bonus loot pool. Suppose in the example above you actually want your event to add a new entity to an existing composition in the arena, with a special item as a reward. You could find that composition and `getEntities()` and `addLoot()` to modify the details of that specific match without affecting the others.

Compositions also define what, if any, `arena_twists` apply to that composition. These twists fire before the fight begins and might do anything from cancelling the fight entirely to modifying the entrants (e.g. your bros or the enemy are poisoned) to adding new enemies. Effectively, these are the same as any other screen in a normal event; you can access the bros chosen to fight in the arena via `_event.m.Bros` or access the selected composition via `World.Arena.getCurrentComposition()`, and so on.

The mod has multiple examples of defining compositions and twists, as well as several constants (such as the chance for an arena twist to occur) defined in `script_hooks/!bdp_constants.nut`. My hope and intent is to make it easy for mod authors (including myself) to add new content and, where needed, hook functions added by BD+ to accomplish the needs of their mod.
