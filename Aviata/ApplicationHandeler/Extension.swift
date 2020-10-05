
import Foundation
import UIKit
import SDWebImage
//MARK: - UIFont

//MARK: - UIView
extension UIView {
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
        public func removeAllConstraints() {
            var _superview = self.superview
            
            while let superview = _superview {
                for constraint in superview.constraints {
                    
                    if let first = constraint.firstItem as? UIView, first == self {
                        superview.removeConstraint(constraint)
                    }
                    
                    if let second = constraint.secondItem as? UIView, second == self {
                        superview.removeConstraint(constraint)
                    }
                }
                
                _superview = superview.superview
            }
            
            self.removeConstraints(self.constraints)
            self.translatesAutoresizingMaskIntoConstraints = true
        
    }
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    func removeLayer(layerName: String) {
        for item in self.layer.sublayers ?? [] where item.name == layerName {
            item.removeFromSuperlayer()
        }
    }
   
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
}
//MARK: - UIButton

//MARK: - CAGradientLayer
extension CAGradientLayer {
    static func setGradientBackground() -> CAGradientLayer {
        let colorTop = UIColor(red: 0.725, green: 0.282, blue: 0.506, alpha: 1).cgColor
        let colorBottom = UIColor(red: 0.58, green: 0.051, blue: 0.047, alpha: 1).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
      
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }

}


extension UIViewController {
    
    func addSubview(_ view: UIView) -> Void {
        self.view.addSubview(view)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func inNavigation() -> UIViewController {
        return UINavigationController(rootViewController: self)
    }
    
    func showAlert(type: AlertMessageType, _ message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        guard !message.isEmpty else { return }
        let alert = UIAlertController(title: type.rawValue, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }

}




//MARK:- UITableViewCell
extension UITableViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

//MARK:- UICollectionViewCell
extension UICollectionViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}
//MARK: - Double

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension String {
    var toURL : URL {
        return URL(string: self)!
    }
    var utfData: Data {
        return Data(utf8)
    }

    var attributedHtmlString: NSAttributedString? {

        do {
            return try NSAttributedString(data: utfData,
            options: [
                      .documentType: NSAttributedString.DocumentType.html,
                      .characterEncoding: String.Encoding.utf8.rawValue
                     ], documentAttributes: nil)
        } catch {
            print("Error:", error)
            return nil
        }
    }
}

extension UILabel {
   func setAttributedHtmlText(_ html: String) {
      if let attributedText = html.attributedHtmlString {
         self.attributedText = attributedText
      }
   }
}

extension Date {
    var daysOffset : String {
            var calendar = Calendar.current
            calendar.timeZone = TimeZone(abbreviation: "GMT")!
            
            
            let componentsSecond = calendar.dateComponents([.second], from: Date(), to: self)
            
            if let second = componentsSecond.second{
                if (0-second) < 60 {
                    return "\(second)" + " секунд"
                }
                if (0-second) > 59 && (0-second) < 60 * 60 {
                    return "\(Int((0-second) / 60))" + " минут"
                }
            }

            
            let components = calendar.dateComponents([.hour], from: Date(), to: self)
            
            if let hour = components.hour{
                if 0 - hour < 24 {
                    return "\(hour)" + " часов"
                }
                if 0 - hour > 24 && 0 - hour < 24 * 7 {
                    return "\(Int(0 - hour / 24))" + " дня"
                }
            }
            
            let componentsWeek = calendar.dateComponents([.weekOfYear], from: Date(), to: self)
            if let weeks = componentsWeek.weekOfYear{
                if 0-weeks < 4 {
                    return "\(0-weeks)" + " недель"
                }
                if 0-weeks > 4 && 0-weeks < 52 {
                    return "\(Int(0-weeks / 4))" + " месяцев"
                }
            }
            var date = String(describing: self)
            date.removeLast(8)
            
            return date
        }
}



    


//MARK: - UIColor
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
