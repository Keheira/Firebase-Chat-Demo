//
//  FCViewController.swift
//  FriendlyChatDemo-iOS
//
//  Created by School on 9/30/17.
//

import UIKit
import Firebase
import FirebaseAuthUI

class FCViewController: UIViewController, UINavigationControllerDelegate {
    
    var ref: DatabaseReference!
    var messages: [DataSnapshot]! = []
    var msglength: NSNumber = 1000
    var storageRef: StorageReference!
    var remoteConfig: RemoteConfig!
    let imageCache = NSCache<NSString, UIImage>()
    var keyboardOnScreen = falsevar placeholderImage = UIImage(name: "ic_account_circle")
    fileprivate var _refHandle: DatabaseHandle!
    fileprivate var _authHandle: AuthStateDidChangeListenerHandle!
    var user: User?
    var displayName = "Anon"
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var imageMessage: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var messagesTable: UITableView!
    @IBOutlet weak var backgroundBlur: UIVisualEffectView!
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet var dismissImageRecognizer: UITapGestureRecognizer!
    @IBOutlet var dismissKeyboardRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        self.signedInStatus(isSignedIn: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscibeFromAllNotifications()
    }
    
    func configureAuth() {}
    
    func configureDatabase() {}
    
    func configureStorage() {}
    
    deinit {}
    
    func configureRemoteConfig() {}
    
    func fetchConfig() {}
    
    func signedInStatus(isSignedIn: Bool) {
        signInButton.isHidden = isSignedIn
        signOutButton.isHidden = !isSignedIn
        messagesTable.isHidden = !isSignedIn
        messageTextField.isHidden = !isSignedIn
        sendButton.isHidden = !isSignedIn
        imageMessage.isHidden = !isSignedIn
        
        if(isSignedIn) {
            messagesTable.rowHeight = UITableViewAutomaticDimension
            messagesTable.estimatedRowHeight = 122.0
            backgroundBlur.effect = nil
            messageTextField.delegate = self
        }
    }
    
    func loginSession()  {
        let authViewController = FUIAuth.defaultAuthUI()!.authViewController()
        self.present(authViewController, animated: true, completion: nil)
    }
    
    func sendMessage(data: [String: String]) {}
    
    func sendPhotoMessage(photoData: Data) {}
    
    func showAlert(title: String, message: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
            alert.addAction(dismissAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func scrollToBottomMessage() {
        if messages.count == 0 {return}
        let bottomMessageIndex = IndexPath(row: messagesTable.numberOfRows(inSection: 0) - 1, section: 0)
        messagesTable.scrollToRow(at: bottomMessageIndex, at: .bottom, animated: true)
    }
}
