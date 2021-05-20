//
//  NotificationViewController.swift
//  Content
//
//  Created by JustinsMac on 19/05/21.
//

import UIKit
import UserNotifications
import UserNotificationsUI


class NotificationViewController: UIViewController, UNNotificationContentExtension {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var bodyLabel: UILabel?
    @IBOutlet weak var image: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.titleLabel?.text = notification.request.content.title
        self.bodyLabel?.text = notification.request.content.body
        guard let body = notification.request.content.userInfo["fcm_options"] as? Dictionary<String, Any>, let imageUrl = body["image"] as? String else { fatalError("Image Link not found") }
        guard let url = URL(string: imageUrl) else { return }
        guard let imageData = try? Data(contentsOf: url) else { return }
        DispatchQueue.main.async {
            self.image?.image = UIImage(data: imageData)
        }
    }

}
