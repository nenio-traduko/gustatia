//
//  GustatiaAppTests+Edit.swift
//  GustatiaUITests
//
//  Created by David Alvarado on 10/20/23.
//

import XCTest

public struct TestRecipe {
    let title: String
    let servings: String
    let prepTime: String
    let cookTime: String
    let ingredients: [(String, String, String)]
    let instructions: [String]
    
    private init(title: String, servings: String, prepTime: String, cookTime: String, ingredients: [(String, String, String)], instructions: [String]) {
        self.title = title
        self.servings = servings
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.ingredients = ingredients
        self.instructions = instructions
    }
    
    public static let KeyLimeCrust = TestRecipe(
        title: "Key Lime Crust",
        servings: "1.00",
        prepTime: "5 min",
        cookTime: "10 min",
        ingredients: [
            ("Graham Cracker Crumbs", "1.5", "cups"),
            ("Brown Sugar", "0.33", "cup"),
            ("Unsalted Butter", "4", "tbsp")
        ],
        instructions: [
            "Preheat oven to 375 °F",
            "In a medium bowl, combine graham cracker crumbs, brown sugar, and melted butter. Stir until the mixture is well combined, and press the mixture firmly into the bottom and up the sides of a 9 X 1.5 in pie pan. The crust should be about 1/4 in thick.",
            "Bake for 10 min or until just slightly browned. Let the crust cool."
        ]
    )
}

final class GustatiaAppTests_NewRecipe: XCTestCase {
    private var app: XCUIApplication!
    private var interactionUtility: XCUITestInteractionUtility!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.activate()
        
        guard app.wait(for: .runningForeground, timeout: 10) else {
            XCTFail("App did not achieve expected state in time")
            return
        }
        
        interactionUtility = XCUITestInteractionUtility(for: app)
        
        // navigate to new recipe view
        app.buttons["Add recipe"].tap()
    }
    
    override func tearDown() {
        let backButton = app.buttons["Recipes"]
        
        if backButton.exists {
            backButton.tap()
        }
    }

    func testNewRecipeScreenDisplaysTitleSection() {
        XCTAssertTrue(app.staticTexts["RECIPE"].exists)
    }
    
    func testNewRecipeScreenDisplaysServingsSection() {
        XCTAssertTrue(app.staticTexts["SERVINGS"].exists)
    }
    
    func testNewRecipeScreenDisplaysPreparationTimeSection() {
        XCTAssertTrue(app.staticTexts["PREPARATION TIME"].exists)
    }
    
    func testNewRecipeScreenDisplaysCookTimeSection() {
        XCTAssertTrue(app.staticTexts["COOK TIME"].exists)
    }
    
    func testNewRecipeScreenDisplaysIngredientsSection() {
        XCTAssertTrue(app.staticTexts["INGREDIENTS"].exists)
    }
    
    func testNewRecipeScreenDisplaysInstructionsSection() throws {
        XCTAssertTrue(try interactionUtility.exists(app.staticTexts["INSTRUCTIONS"]))
    }
    
    func testBackButtonToRecipesExists() {
        XCTAssertTrue(app.buttons["Recipes"].exists)
    }
    
    func testTitleExists() {
        XCTAssertTrue(app.navigationBars["Edit Recipe"].exists)
    }
    
    func testNewRecipeScreenCreatesNewRecipe() throws {
        // fill in title
        try interactionUtility.type(into: app.textFields["Title"], text: TestRecipe.KeyLimeCrust.title)
        
        // increment servings
        try interactionUtility.step("Servings Stepper", to: TestRecipe.KeyLimeCrust.servings)
        
        // increment prep time
        try interactionUtility.step("Preparation Time Stepper", to: TestRecipe.KeyLimeCrust.prepTime)
        
        // increment cook time
        try interactionUtility.step("Cook Time Stepper", to: TestRecipe.KeyLimeCrust.cookTime)
        
        // add ingredients
        for index in TestRecipe.KeyLimeCrust.ingredients.indices {
            let (name, amount, units) = TestRecipe.KeyLimeCrust.ingredients[index]
            
            let nameTextField = app.textFields["Ingredient \(index) Name"]
            try interactionUtility.type(into: nameTextField, text: name)
            
            let amountTextField = app.textFields["Ingredient \(index) Amount"]
            try interactionUtility.type(into: amountTextField, text: amount)
            
            let unitsTextField = app.textFields["Ingredient \(index) Units"]
            try interactionUtility.type(into: unitsTextField, text: units)
            
            if index < TestRecipe.KeyLimeCrust.ingredients.endIndex - 1 {
                let addIngredientButton = app.buttons["Add Ingredient"]
                try interactionUtility.tap(addIngredientButton)
            }
        }
         
        for index in TestRecipe.KeyLimeCrust.instructions.indices {
            let instructionTextField = app.textViews["Step \(index)"]
            try interactionUtility.type(into: instructionTextField, text: TestRecipe.KeyLimeCrust.instructions[index])
            
            if index < TestRecipe.KeyLimeCrust.instructions.endIndex - 1 {
                let addStepButton = app.buttons["Add Step"]
                try interactionUtility.tap(addStepButton)
            }
        }
        
        app.buttons["Done"].tap()
        app.buttons["Key Lime Crust"].swipeLeft()
        app.buttons["Delete"].tap()
    }
}
