

import UIKit

// A delay function
func delay(_ seconds: Double, completion: @escaping ()->Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

class ViewController: UIViewController {
  
  // MARK: IB outlets
  private var timer: Timer?
  @IBOutlet var loginButton: UIButton!
  @IBOutlet var heading: UILabel!
  @IBOutlet var username: UITextField!
  @IBOutlet var password: UITextField!
  
  @IBOutlet var cloud1: UIImageView!
  @IBOutlet var cloud2: UIImageView!
  @IBOutlet var cloud3: UIImageView!
  @IBOutlet var cloud4: UIImageView!
  @IBOutlet weak var cloudOneCenterX: NSLayoutConstraint!
  @IBOutlet weak var cloudTwoCenterX: NSLayoutConstraint!
  @IBOutlet weak var cloudeThreeHeight: NSLayoutConstraint!
  @IBOutlet weak var cloudThreeWidth: NSLayoutConstraint!
  
  @IBOutlet weak var cloudFourHieght: NSLayoutConstraint!
    
  @IBOutlet weak var cloudFourWidth: NSLayoutConstraint!
    
    
    // MARK: further UI
  
  let spinner = UIActivityIndicatorView(style: .whiteLarge)
  let status = UIImageView(image: UIImage(named: "banner"))
  let label = UILabel()
  let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
  
  var statusPosition = CGPoint.zero
  
  // MARK: view controller methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //set up the UI
    loginButton.layer.cornerRadius = 8.0
    loginButton.layer.masksToBounds = true
    
    spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
    spinner.startAnimating()
    spinner.alpha = 0.0
    loginButton.addSubview(spinner)
    
    status.isHidden = true
    status.center = loginButton.center
    view.addSubview(status)
    
    label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
    label.font = UIFont(name: "HelveticaNeue", size: 18.0)
    label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
    label.textAlignment = .center
    status.addSubview(label)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(showView), userInfo: nil, repeats: true)
    self.timer = timer
  }
    
    @objc func showView(){
      cloudOneCenterX.constant = self.view.frame.width
      cloudTwoCenterX.constant = -self.view.frame.width
        cloudThreeWidth.constant = 2 * cloudThreeWidth.constant
      cloudeThreeHeight.constant = 2 * cloudeThreeHeight.constant
      cloudFourWidth.constant = 2 * cloudFourWidth.constant
      cloudFourHieght.constant = 2*cloudFourHieght.constant
      UIView.animate(withDuration: 3, delay: 0, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
          self.cloudOneCenterX.constant = -self.view.frame.width
          self.cloudTwoCenterX.constant = self.view.frame.width + self.cloud2.frame.width
          
          
        }
      self.cloudFourHieght.constant = self.cloudFourHieght.constant / 2
      self.cloudFourWidth.constant = self.cloudFourWidth.constant / 2
      self.cloudThreeWidth.constant = self.cloudThreeWidth.constant / 2
      self.cloudeThreeHeight.constant = self.cloudeThreeHeight.constant / 2
      UIView.animate(withDuration: 2, delay: 3, animations: {
          self.view.layoutIfNeeded()
      })
    }
  
  // MARK: further methods
  
  @IBAction func login() {
    view.endEditing(true)
  }
  
  // MARK: UITextFieldDelegate
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let nextField = (textField === username) ? password : username
    nextField?.becomeFirstResponder()
    return true
  }
  
}
