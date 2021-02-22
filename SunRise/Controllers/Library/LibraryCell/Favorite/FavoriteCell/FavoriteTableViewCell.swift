import UIKit

final class FavoriteTableViewCell: UITableViewCell, Reusable, NibLoadable {

    @IBOutlet weak private var songImage: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var userLabel: UILabel!
    @IBOutlet weak private var favoriteButton: UIButton!
    
    var favoriteButtonAction: ( () -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        songImage.image = .none
        titleLabel.text = .none
        userLabel.text = .none
        favoriteButton.isSelected = true
    }
    
    // MARK: - Action
    
    @IBAction func detailPressed(sender: Any) {
        
    }
    
    @IBAction func favoritePressed(sender: Any) {
        favoriteButtonAction?()
    }
    
    // MARK: - Config
    
    func binding(track: FavoriteManagedObject) {
        titleLabel.text = track.title
        userLabel.text = track.userName
        
        track.artworkURL?.downloadImage() { [weak self] result in
            switch result {
            case .failure(_):
                break
            case .success(let image):
                if let image = image {
                    self?.songImage.image = image
                }
            }
        }
    }
}
