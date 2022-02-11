//
//  ViewController.swift
//  Concurency
//
//  Created by Taof on 20/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    let queue = DispatchQueue(label: "queue.test", qos: .default, attributes: .concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onSleep(_ sender: Any) {
        sleep(5)
    }
    
    @IBAction func updateUITheBadway(_ sender: Any) {
        queue.async {
            for i in 1...5 {
                sleep(1)
                self.label.text = "\(i)"
            }
        }
    }
    
    @IBAction func updateUITheGoodway(_ sender: Any) {
        queue.async {
            for i in 1...5 {
                sleep(1)
                DispatchQueue.main.async {
                    self.label.text = "\(i)"
                }
            }
        }
    }
    
    @IBAction func runTaskInSync(_ sender: Any) {
        queue.sync {
            for i in 1...5 {
                Thread.sleep(forTimeInterval: Double.random(in: 0.01...0.09))
                print("i = \(i)")
            }
        }
        
        queue.sync {
            for j in 1...5 {
                Thread.sleep(forTimeInterval: Double.random(in: 0.01...0.09))
                print("j = \(j)")
            }
        }
    }
    
    @IBAction func runTaskInAsync(_ sender: Any) {
        queue.async {
            for i in 1...5 {
                Thread.sleep(forTimeInterval: Double.random(in: 0.01...0.09))
                print("i = \(i)")
            }
        }
        
        queue.async {
            for j in 1...5 {
                Thread.sleep(forTimeInterval: Double.random(in: 0.01...0.09))
                print("j = \(j)")
            }
        }
    }
}

