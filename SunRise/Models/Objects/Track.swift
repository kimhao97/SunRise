import Foundation
import UIKit

final class Track: Codable {

    let track_id: Int?
    let title: String?
    let genre: String?
    let stream_url: String?
    let artwork_url: String?

    let user_id: Int
    let user_name: String

    enum SongKeys: String, CodingKey {
        case track_id = "id"
        case title
        case user_name = "user"
        case genre
        case stream_url
        case artwork_url
    }

    enum UserKeys: String, CodingKey {
        case user_id = "id"
        case user_name = "username"
    }

    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: SongKeys.self)

        track_id = try container.decode(Int.self, forKey: .track_id)
        title = try container.decode(String.self, forKey: .title)
        genre = try container.decode(String.self, forKey: .genre)
        stream_url = try container.decode(String.self, forKey: .stream_url)
        artwork_url = try container.decode(String.self, forKey: .artwork_url)

        let user = try container.nestedContainer(keyedBy: UserKeys.self, forKey: .user_name)

        user_id = try user.decode(Int.self, forKey: .user_id)
        user_name = try user.decode(String.self, forKey: .user_name)
    }
}
