//
//  LocalFileManager.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/04.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() {}
    
    func saveCoverImage(image: UIImage, cache_dir: String, id: String) {
        
        createFolderIfNeeded(cache_dir: cache_dir)
        
        guard
            
            let data = image.pngData(),
            let url = getURLForCoverImage(cache_dir: cache_dir, id: id) // cache/cover/id
                
        else {return}
        
        do {
            try data.write(to: url)
            
        } catch let error {
            print("error saving image. \(error)")
        }
    }
    
    func saveContentsImage(image: UIImage, cache_dir: String, num: Int) {
        
        createFolderIfNeeded(cache_dir: cache_dir)
        
        guard
            
            let data = image.pngData(),
            let url = getURLForContentsImage(cache_dir: cache_dir, num: num)
            
        else {return}
        
        do {
            try data.write(to: url)
            
        } catch let error {
            print("error saving image. \(error)")
        }
    }
    
    func getCoverImage(cache_dir: String, id: String) -> UIImage? {
        
        guard let url = getURLForCoverImage(cache_dir: cache_dir, id: id) else { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    func getContentsImage(cache_dir: String, num: Int) -> UIImage? {
        
        guard let url = getURLForContentsImage(cache_dir: cache_dir, num: num) else { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    func removeContentsImage(cache_dir: String) {
        
        guard let url = getURLFolder(cache_dir: cache_dir) else {return}
        
        do {
            try FileManager.default.removeItem(atPath: url.path)
        } catch let error {
            print("error removing Item. \(error)")
        }
    }
    
    private func createFolderIfNeeded(cache_dir: String) {
        
        guard let url = getURLFolder(cache_dir: cache_dir) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                
            } catch let error {
                print("error creating directory. \(error)")
            }
        }
    }
    
    private func getURLFolder(cache_dir: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        
        return url.appendingPathComponent(cache_dir) // cache/cover or cache/contents
    }
    
    private func getURLForCoverImage(cache_dir: String, id: String) -> URL? {
        
        guard let folderURL = getURLFolder(cache_dir: cache_dir) else { return nil } // Libaray/cache/cover

        return folderURL.appendingPathComponent(id) // Library/cache/cover/id
    }
    
    private func getURLForContentsImage(cache_dir: String, num: Int) -> URL? {
        
        guard let folderURL = getURLFolder(cache_dir: cache_dir) else {return nil}

        return folderURL.appendingPathComponent("contents_\(num)") // Libary/cache/contents/contents_(num)
    }
}
