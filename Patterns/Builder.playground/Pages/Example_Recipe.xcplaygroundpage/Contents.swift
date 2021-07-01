//: Builder pattern: Recipe example (uses director).
//:
//: Reference: https://stackoverflow.com/questions/4313172/builder-design-pattern-why-do-we-need-a-director
struct Cake { }

struct ChocolateCakeBaker {
    func addLiquids() -> ChocolateCakeBaker {
        // ... some logic
        self
    }
    func mixWell() -> ChocolateCakeBaker {
        // ... some logic
        self
    }
    func addDryIngredients() -> ChocolateCakeBaker {
        // ... some logic
        self
    }
    func pourBatterIntoBakingPan() -> ChocolateCakeBaker {
        // ... some logic
        self
    }
    func bake() -> ChocolateCakeBaker {
        // ... some logic
        self
    }
    
    func cookCake() -> Cake {
        // pass the data
        .init()
    }
}


// MARK: - Director
struct Chef {
    func cookChocolateCake(_ baker: ChocolateCakeBaker) -> ChocolateCakeBaker {
        baker
            .addLiquids()
            .mixWell()
            .addDryIngredients()
            .mixWell()
            .pourBatterIntoBakingPan()
            .bake()
    }
}


// MARK: - Main
// Without a director (not following a recipe)
ChocolateCakeBaker()
    .addLiquids()
    .addDryIngredients()
    .mixWell()
    .cookCake()

// With a director (following a recipe)
Chef()
    .cookChocolateCake(ChocolateCakeBaker())
    .cookCake()
