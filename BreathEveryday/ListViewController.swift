//
//  ListViewController.swift
//  BreathEveryday
//
//  Created by Lucy on 2017/3/20.
//  Copyright © 2017年 Bomi. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listTableView: UITableView!
    @IBAction func homeBtn(_ sender: Any) {
        displayHomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: Identifier.listCell.rawValue, bundle: nil), forCellReuseIdentifier: Identifier.listCell.rawValue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Appearance of Back btn
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.backBarButtonItem = backItem // backBarBtn belongs to previous controller
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listTableView.dequeueReusableCell(withIdentifier: Identifier.listCell.rawValue, for: indexPath)
        if let dequeCell = cell as? ListTableViewCell {
            
            dequeCell.viewDetailBtn.addTarget(self, action: #selector(viewChangeToDetailPage), for: .touchUpInside)
            
            return dequeCell
        }
        
        return cell
    }

    func viewChangeToDetailPage(sender: UIButton) {
        
        guard let cell = sender.superview?.superview?.superview as? ListTableViewCell else { return }
        performSegue(withIdentifier: Identifier.detailView.rawValue, sender: cell)
        
    }
    
    func displayHomeView() {
        
        if let displayView = storyboard?.instantiateViewController(withIdentifier: Identifier.homeView.rawValue) as? HomeViewController {
            let subView = UIView()
            subView.layer.frame = displayView.view.frame
            subView.backgroundColor = UIColor.white
            displayView.view.addSubview(subView)
            subView.layer.opacity = 1
            self.present(displayView, animated: false, completion: {
                UIView.animate(withDuration: 1, animations: {
                    subView.layer.opacity = 0.0
                }, completion: { (_) in
                    subView.removeFromSuperview()
                })
            })
        }
        
    }
    
}







