//
//  ArrayState.swift
//  ActorApp
//
//  Created by Amol Pawar on 30/07/22.
//

import Foundation
import UIKit

actor ArrayState {

    var element: [String] = [];

    func add(elm: String) {
        self.element.append(elm)
    }

    func printArray(obj: SendableStruct = SendableStruct()) {
        print(element)
    }
}


struct SendableStruct: Sendable {

}

class DownloadArrayImages {


    func download() async -> [UIImage] {
        let array = ["https://source.unsplash.com/user/c_v_r/1900x800", "https://source.unsplash.com/user/c_v_r/1900x800", "https://source.unsplash.com/user/c_v_r/1900x800"]
        print("0")
        async let one = photoDownload(array[0])
          print("1")
        async let two = photoDownload(array[1])
          print("2")
        async let three = photoDownload(array[2])
        print("3")
        var photos = await [one, two, three]


        print("4")
        let one1 = await photoDownload(array[0])
        print("5")
        let two2 = await photoDownload(array[1])
        print("6")
        let three3 = await photoDownload(array[2])
        print("7")
        photos.append(contentsOf: [one1, two2, three3])

        return photos

    }

    private func photoDownload(_ string: String) async -> UIImage {
        if let url = URL(string: string) {
            let v = try? await URLSession.shared.data(from: url)
            return UIImage(data: v!.0) ?? UIImage(systemName: "heart")!
        }

        return UIImage(systemName: "heart")!
    }
}
