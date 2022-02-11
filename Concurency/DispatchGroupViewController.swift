//
//  DispatchGroupViewController.swift
//  Concurency
//
//  Created by Taof on 20/01/2022.
//

import UIKit

class DispatchGroupViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressView1: UIProgressView!
    @IBOutlet weak var progressView2: UIProgressView!
    @IBOutlet weak var progressView3: UIProgressView!
    
    let queue = DispatchQueue.global(qos: .background)
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func runTask(_ sender: Any) {
        self.label.text = "In Progress"
        queue.async {
            self.group.enter()
            for i in 1...100 {
                DispatchQueue.main.async {
                    self.progressView1.progress = Float(i) / 100
                }
                Thread.sleep(forTimeInterval: 0.01)
            }
            self.group.leave()
        }
        
        queue.async {
            self.group.enter()
            for i in 1...100 {
                DispatchQueue.main.async {
                    self.progressView2.progress = Float(i) / 100
                }
                Thread.sleep(forTimeInterval: 0.05)
            }
            self.group.leave()
        }
        
//        queue.async(group: group, execute: DispatchWorkItem(block: {
//            for i in 1...100 {
//                DispatchQueue.main.async {
//                    self.progressView3.progress = Float(i) / 100
//                }
//                Thread.sleep(forTimeInterval: 0.02)
//            }
//        }))
        queue.async {
            self.group.enter()
            for i in 1...100 {
                DispatchQueue.main.async {
                    self.progressView3.progress = Float(i) / 100
                }
                Thread.sleep(forTimeInterval: 0.02)
            }
            self.group.leave()
        }
        
        group.notify(queue: .main) {
            self.label.text = "Done !!!"
        }
    }
    
}
