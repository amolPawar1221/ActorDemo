//
//  ContentView.swift
//  ActorApp
//
//  Created by Amol Pawar on 30/07/22.
//

import SwiftUI

struct ContentView: View {

    @State var element: String = ""
    @State var images: [UIImage] = [];

    var actorObject: ArrayState = ArrayState()

    var queue1 = DispatchQueue(label: "com.gslab.actorapp.contentview", qos: .default, attributes: [], autoreleaseFrequency: .inherit, target: nil)

    var queue2 = DispatchQueue(label: "com.gslab.actorapp.contentview1", qos: .default, attributes: [], autoreleaseFrequency: .inherit, target: nil)

    func startQueue() {
        print("start queue1")
        queue1.sync {
            queue2.async {
                print("queue2")
                for i in 1...4 {
                    print(i)
                }
            }
            print("queue1")
            for j in 5...10 {
                print(j)
            }
        }
        print("end of queue1")
    }



    var body: some View {
        VStack(spacing: 20) {
            TextField("enter element", text: $element)
                .textFieldStyle(.roundedBorder)
            Button {
                Task {
                    await addElement()
                    element = ""
                }
            } label: {
                Text("Add element")
            }
            .padding()
            .background(.cyan)

            Button {
                Task {
                    await getImages()
                }
            } label: {
                Text("show element")
            }
            .padding()
            .background(.cyan)

            ForEach(images, id: \.self) { image in
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
            }
        }
        .padding()
        .background(
            Rectangle()
                .fill(.white)
                .cornerRadius(10)
                .shadow(radius: 10, x: -5, y: 5)
        )
        .padding()
    }

    func addElement() async {
        await actorObject.add(elm: element)
    }

    func show() async {
        await actorObject.printArray()
    }

    func getImages() async {
        let download = DownloadArrayImages()
        images = await download.download()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
