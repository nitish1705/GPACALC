import XCTest

final class GPACALCUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
 
    override func tearDownWithError() throws {
        app.terminate()
        app = nil
    }
    
    func testFunctionalitySettingBack() {
        let navBarSettings = app.navigationBars.buttons["settingsNavBarButton"]
//        XCTAssertTrue(navBarSettings.waitForExistence(timeout: 5.0))
        navBarSettings.tap()
        
        let settingsTitle = app.staticTexts["settingsTitle"]
//        XCTAssertTrue(settingsTitle.waitForExistence(timeout: 5.0))
        XCTAssertEqual(settingsTitle.label, "Settings")
        
        let navBarhome = app.navigationBars.buttons["homeButton"]
//        XCTAssertTrue(navBarhome.waitForExistence(timeout: 5.0))
        navBarhome.tap()
        
        let homeTitle = app.staticTexts["hometitle"]
//        XCTAssertTrue(homeTitle.waitForExistence(timeout: 5.0))
        XCTAssertEqual(homeTitle.label, "GPA & CGPA Calculator")
    }
}
