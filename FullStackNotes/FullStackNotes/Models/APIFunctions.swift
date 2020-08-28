//
//  APIFunctions.swift
//  FullStackNotes
//
//  Created by Simon Barrett on 28/08/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import Foundation
import Alamofire

struct Note: Decodable {
    var _id: String
    var title: String
    var note: String
    var date: String
}

class APIFunctions {
    
    var delegate: DataDelegate?
    static let functions = APIFunctions()
    
    //MARK: - Functions
    
    func fetchNotes() {
        
        AF.request("http://192.168.0.16:8081/fetch").response { response in
    
            print(response.data)
            let data = String(data: response.data!, encoding: .utf8)
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    func AddNote(title: String, note: String, date: String) {
        
        AF.request("http://192.168.0.16:8081/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "note": note, "date": date]).responseJSON { response in
            print(response)
        }
        
    }
    
    func updateNote(title: String, note: String, date: String, id: String) {
        
        AF.request("http://192.168.0.16:8081/update", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "note": note, "date": date, "id": id]).responseJSON { response in
            print(response)
        }
    }
    
    func deleteNote(id: String) {
        
        AF.request("http://192.168.0.16:8081/delete", method: .post, encoding: URLEncoding.httpBody, headers: ["id": id]).responseJSON { response in
            print(response)
        }
    }
    
    

}
