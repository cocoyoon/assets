//
//  NetworkManage.swift
//  gotcha
//
//  Created by SoYoun Jeong on 2022/10/23.
//

import Foundation
import Firebase
import FirebaseFirestore

class NetworkManager {
    
    static func writeDataFS(collectionName: String, data: [String: Any], _ completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        guard let user = Auth.auth().currentUser else { return }

        let docRef = db.collection(collectionName).document(user.uid)
        docRef.setData(data) { error in
            if let error = error {
                print("Error writing data on FS. \(error)")
            } else {
                print("Success writing data on FS")
                completion()
            }
        }
    }
}
