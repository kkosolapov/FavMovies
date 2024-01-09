import UIKit

class FavMoviesViewController: UIViewController {
    
    @IBOutlet weak var TitleMovieTxtFld: UITextField?
    @IBOutlet weak var YearMovieTxtFld: UITextField?
    @IBOutlet weak var AddMovieBtn: UIButton?
    @IBOutlet weak var FavMoviesTblView: UITableView?
    
    var favoriteMovies: [Movies] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        FavMoviesTblView?.dataSource = self
        FavMoviesTblView?.delegate = self
    }
    
    @IBAction func AddMovieFavList(_ sender: Any) {
        guard let title = TitleMovieTxtFld?.text, !title.isEmpty else {
            showAlert(title: "Empty movie title", message: "Enter movie title")
            return
        }
        
        
        guard let movietitleLength = TitleMovieTxtFld?.text, movietitleLength.count < Constants().titleLength else {
            showAlert(title: "Too long movie title", message: "Movie title must be less than 30 symbols")
            return
        }
        
        guard let yearText = YearMovieTxtFld?.text, !yearText.isEmpty,
              let year = Int(yearText), Constants().beginYear..<Constants().endYear ~= year else {
            showAlert(title: "Invalid movie year", message: "Enter a valid movie year between 1960 and 2024")
            return
        }
        
        let newMovie = Movies(title: title, year: year)
        
        if isDuplicateMovie(newMovie) {
            showAlert(title: "Duplicate Movie", message: "The movie is already in your favorites list.")
            return
        }
        
        favoriteMovies.append(newMovie)
        FavMoviesTblView?.reloadData()
    }
    
    func isDuplicateMovie(_ movie: Movies) -> Bool {
        return favoriteMovies.contains { $0.title == movie.title && $0.year == movie.year }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension FavMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieId", for: indexPath)
        let movie = favoriteMovies[indexPath.row]
        cell.textLabel?.text = "\(movie.title) \(movie.year)"
        return cell
    }
}
