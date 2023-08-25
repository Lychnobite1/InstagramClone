//
//  ImagePicker.swift
//  Archy
//
//  Created by MURAT BAŞER on 21.08.2023.
//

import Foundation
import SwiftUI
import UIKit
struct ImagePicker : UIViewControllerRepresentable {
    @Binding var selectedImage : UIImage?
    @Binding var isPickerShow : Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent : ImagePicker
    init(_ picker : ImagePicker) {
        self.parent = picker
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("image selected")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.parent.selectedImage = image
            }
        }
        parent.isPickerShow = false
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("image cancelled")
        parent.isPickerShow = false
    }
}


