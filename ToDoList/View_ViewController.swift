//
//  View_ViewController.swift
//  ToDoList
//
//  Created by Güney Eroğlu on 26.05.2022.
//

import UIKit
import RealmSwift

class View_ViewController: UIViewController {
    
    public var item: ToDoListItem?
    public var deletionHandler: (() -> Void)?
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    private let realm = try! Realm()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemLabel.text = item?.item
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }

    @objc private func didTapDelete() {
        guard let myItem = self.item else {
            return
        }
        
        realm.beginWrite()
        realm.delete(myItem)
        try! realm.commitWrite()
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
}
