import XCTest
@testable import FavMovies

final class FavMoviesTests: XCTestCase {
    
    var favMoviesviewController: FavMoviesViewController!
    
    override func setUp() {
        super.setUp()
        favMoviesviewController = FavMoviesViewController()
        _ = favMoviesviewController.view
    }
    
    override func tearDown() {
        favMoviesviewController = nil
        super.tearDown()
    }
    
    func testAddMovieFavListWithTitleAndYear() {
        
        favMoviesviewController.TitleMovieTxtFld?.text = "Inception"
        favMoviesviewController.YearMovieTxtFld?.text = "2010"
        favMoviesviewController.AddMovieFavList(self)
        
        XCTAssertEqual(favMoviesviewController.favoriteMovies.count, 0)
    }
        
    func testAddMovieFavListWithoutTitle() {
        
        favMoviesviewController.YearMovieTxtFld?.text = "2010"
        favMoviesviewController.AddMovieFavList(self)
        
        XCTAssertEqual(favMoviesviewController.favoriteMovies.count, 0)
    }
    
    func testAddMovieFavListWithoutYear() {
        
        favMoviesviewController.TitleMovieTxtFld?.text = "Inception"
        favMoviesviewController.AddMovieFavList(self)
        
        XCTAssertEqual(favMoviesviewController.favoriteMovies.count, 0)
    }
    
    func testAddMovieFavListWithoutTitleAndYear() {
        
        favMoviesviewController.TitleMovieTxtFld?.text = ""
        favMoviesviewController.AddMovieFavList(self)
        
        favMoviesviewController.YearMovieTxtFld?.text = ""
        favMoviesviewController.AddMovieFavList(self)
        
        XCTAssertEqual(favMoviesviewController.favoriteMovies.count, 0)
    }
    
}
