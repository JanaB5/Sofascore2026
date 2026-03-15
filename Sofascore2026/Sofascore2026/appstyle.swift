import UIKit

struct AppStyle {
    
    struct Colors {
        static let mainBackground = UIColor.white
        static let primaryLabel = UIColor.black
        static let secondaryLabel = UIColor.gray
        static let viewBackground = UIColor.secondarySystemBackground
    }
    
    struct Fonts {
        static func bold(size: CGFloat) -> UIFont {
            return UIFont.boldSystemFont(ofSize: size)
        }
        
        static func regular(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size)
        }
        
        static let header = Fonts.bold(size: 24)
        static let body = Fonts.regular(size: 16)
        static let status = Fonts.bold(size: 14)
    }
    
    struct Strings {
        static let homeVsAway = "%@ vs %@"
        static let statusPrefix = "Status: "
    }
    
    struct Formatters {
        static let date: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy. HH:mm"
            return formatter
        }()
    }
}
