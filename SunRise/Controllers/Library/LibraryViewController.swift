import UIKit

private enum LibraryConstraints{
    static let heightForRowTableView: CGFloat = 160
}

enum Type: Int {
    case createPlaylist = 0, favorite, playlist
}

final class LibraryViewController: BaseViewController {
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var playButton: UIButton!
    @IBOutlet weak private var favoriteButton: UIButton!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var userTitle: UILabel!
    
    private let viewModel = LibraryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateData()
        updateUI()
    }
    
    // MARK: - Config
    
    override func setupData() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LibraryTableViewCell.nib, forCellReuseIdentifier: LibraryTableViewCell.reuseIdentifier)
        
    }
    
    override func setupUI() {
        self.navigationItem.title = "Library"
        
        favoriteButton.image = UIImage(named: "ic-heart-white")
        favoriteButton.selectedImage = UIImage(named: "ic-heart-green")
        
        playButton.image = UIImage(systemName: "play.fill")
        playButton.selectedImage = UIImage(systemName: "pause.fill")
    }
    
    // MARK: - Update
    
    private func updateData() {
        viewModel.fetchFavorite()
    }
    
    private func updateUI() {
        
        tableView.reloadData()
        
        switch Player.shared.state {
        case .isPlaying:
            playButton.isSelected = true
        case .stopped:
            playButton.isSelected = false
        }
        
        if let playing = viewModel.fetchTrackPlaying() {
            titleLabel.text = playing.title
            userTitle.text = playing.userName
            favoriteButton.isSelected = viewModel.isLiked(with: Int(playing.id))
        }
    }
    
    // MARK: - ACTION
    
    @IBAction func playPressed(sender: Any) {
        playButton.isSelected.toggle()
        
        viewModel.player.state = playButton.isSelected ? .isPlaying : .stopped
    }
    
    @IBAction func favoritePressed(sender: Any) {
        favoriteButton.isSelected.toggle()
        
        if favoriteButton.isSelected {
            viewModel.saveFavorite()
        } else {
            viewModel.removeFavorite()
        }
    }
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView,
                cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LibraryTableViewCell.reuseIdentifier,
                                                  for: indexPath) as? LibraryTableViewCell else { return LibraryTableViewCell() }
        cell.selectionStyle = .none
        
        if let cellType = Type(rawValue: indexPath.row) {
            cell.binding(type: cellType)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        if let cellType = Type(rawValue: indexPath.row) {
            switch cellType {
            case .createPlaylist:
                break
            case .favorite:
                let vc = FavoriteViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LibraryConstraints.heightForRowTableView
    }
}
