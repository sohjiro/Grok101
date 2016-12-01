//
//  ViewController.swift
//  Grok101
//
//  Created by MakingDevs on 30/11/16.
//  Copyright © 2016 MakingDevs. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)


    // MARK: Get Todo #1
    Todo.todoByID(id: 1) { result in
      if let error = result.error {
        print("error calling POST on /todos/")
        print(error)
        return
      }
      guard let todo = result.value else {
        print("error calling POST on /todos/ result is nil")
        return
      }

      // success!
      print(todo.description())
      print(todo.title)

      guard let newTodo = Todo(title: "My first todo", id: nil, userId: 1, completedStatus: true) else {
        print("error: newTodo isn't a Todo")
        return
      }

      newTodo.save { result in
        guard result.error == nil else {
          print("error calling POST on /todos/")
          print(result.error!)
          return
        }
        guard let todo = result.value else {
          print("error calling POST on /todos/ result is nil")
          return
        }

        // success!
        print(todo.description())
        print(todo.title)
      }
    }
  }
}

