//
//  Todo+Networking.swift
//  Grok101
//
//  Created by MakingDevs on 30/11/16.
//  Copyright © 2016 MakingDevs. All rights reserved.
//

import Foundation
import Alamofire

enum BackendError: Error {
  case objectSerialization(reason: String)
}

extension Todo {
  init?(json: [String: Any]) {
    guard let title = json["title"] as? String,
      let userId = json["userId"] as? Int,
      let completed = json["completed"] as? Bool else {
        return nil
    }

    let idValue = json["id"] as? Int

    self.init(title: title, id: idValue, userId: userId, completedStatus: completed)
  }

  static func todoByID(id: Int, completionHandler: @escaping(Result<Todo>) -> Void) {
    Alamofire.request(TodoRouter.get(id)).responseJSON { response in
      let result = Todo.todoFromResponse(response: response)
      completionHandler(result)
    }
  }

  func toJSON() -> [String: Any] {
    var json = [String: Any]()
    json["title"] = title
    if let id = id {
      json["id"] = id
    }
    json["userId"] = userId
    json["completed"] = completed
    return json
  }

  func save(completionHandler: @escaping(Result<Todo>) -> Void) {
    let fields = self.toJSON()
    Alamofire.request(TodoRouter.create(fields)).responseJSON { response in
      let result = Todo.todoFromResponse(response: response)
      completionHandler(result)
    }
  }

  private static func todoFromResponse(response: DataResponse<Any>) -> Result<Todo> {
    guard response.result.error == nil else {
      print(response.result.error!)
      return .failure(response.result.error!)
    }

    guard let json = response.result.value as? [String: Any] else {
      print("didn't get todo object as JSON from API")
      return .failure(BackendError.objectSerialization(reason: "Did not get JSON dictionary in response"))
    }

    guard let todo = Todo(json: json) else {
      return .failure(BackendError.objectSerialization(reason: "Could not create Todo object from JSON"))
    }

    return .success(todo)
  }

}
