//
//  Todo.swift
//  Grok101
//
//  Created by MakingDevs on 30/11/16.
//  Copyright © 2016 MakingDevs. All rights reserved.
//

import Foundation

struct Todo {
  var title: String
  var id: Int?
  var userId: Int
  var completed: Bool

  init?(title: String, id: Int?, userId: Int, completedStatus: Bool) {
    self.title = title
    self.id = id
    self.userId = userId
    self.completed = completedStatus
  }

  func description() -> String {
    return "ID: \(self.id)" +
           "User ID: \(self.userId)" +
           "Title: \(self.title)\n" +
           "Completed: \(self.completed)"
  }

}
