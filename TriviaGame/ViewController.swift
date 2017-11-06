//
//  ViewController.swift
//  TriviaGame
//
//  Created by Keith chungag  on 10/24/17.
//  Copyright © 2017 keeko. All rights reserved.
//

import UIKit

var genInfo: [Results] = []

//structs for getting data in JSON
struct Question: Decodable
{
    let response_code: Int
    let results: [Results]
}
struct Results: Decodable
{
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

class ViewController: UIViewController {
    
    //labels
    @IBOutlet weak var question1: UILabel!
    @IBOutlet weak var correct1: UILabel!
    
    @IBOutlet weak var aLabel: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var cLabel: UILabel!
    @IBOutlet weak var dLabel: UILabel!
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //button tags
        aButton.tag = 0
        bButton.tag = 1
        cButton.tag = 2
        dButton.tag = 3
        
        
        //API stuff
        let jsonUrlString = "https://opentdb.com/api.php?amount=1&type=multiple"
        guard let url = URL(string: jsonUrlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do
            {
                let question = try
                JSONDecoder().decode(Question.self, from: data)
                //print("here")
                genInfo = question.results
            }
            catch let jsonErr
            {
                print("Error: ", jsonErr)
            }
            
            //assigning labels
            print(genInfo)
            self.question1.text = genInfo[0].question
            self.aLabel.text = genInfo[0].incorrect_answers[0]
            self.bLabel.text = genInfo[0].incorrect_answers[1]
            self.cLabel.text = genInfo[0].correct_answer
            self.dLabel.text = genInfo[0].incorrect_answers[2]
            
            self.correct1.text = ""
   
        }.resume()
  
        
    }
    
    
    
    @IBAction func userAnswer(_ sender: UIButton)
    {
        if sender.tag == 2
        {
            self.correct1.text = "Correct!"
        }
        else
        {
            self.correct1.text = "Incorrect"
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

