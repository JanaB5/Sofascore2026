import UIKit

enum AppFonts {
    static func robotoBold(size: CGFloat) -> UIFont {
        UIFont(name: "Roboto-Bold", size: size) ?? .boldSystemFont(ofSize: size)
    }
    
    static func robotoRegular(size: CGFloat) -> UIFont {
        UIFont(name: "Roboto-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func robotoCondensed(size: CGFloat) -> UIFont {
        UIFont(name: "RobotoCondensed-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static let header = robotoBold(size: 24)
    static let body = robotoRegular(size: 16)
    static let status = robotoCondensed(size: 14)
}
