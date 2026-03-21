import Foundation
import UIKit

enum AppFormatters {
    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy. HH:mm"
        return formatter
    }()
}
