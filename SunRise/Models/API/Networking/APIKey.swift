import Foundation

extension APIManager {
    enum APIKey {
        case ClientID
        
        var localizedDescription: String {
            switch self {
            case .ClientID:
                return "INSERT YOUR CLIENT ID"
            }
        }
    }
}
