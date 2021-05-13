//
//  ContentView.swift
//  RibbonUI
//
//  Created by Abi on 12/05/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("hello").toolbar(content: {
            VStack(alignment : .center){
                RibbonView()
            }
        }).frame(minWidth : 600,maxWidth: .infinity, minHeight: 300,maxHeight: .infinity)
    }
}



struct RibbonView: View {
    @Namespace var nspace
    @State var list = ["Paris","Bora Bora","Glacier National Park","London"]
    @State var chosen = "Paris"
    @State var ishovered : Bool = false
    @State var hoveredText : String = ""
    var body: some View {
        HStack(alignment:.center,spacing : 5){
            Spacer()
            ForEach(list, id:\.self){ (element:String) in
                VStack(alignment:.center,spacing : 0){
                    Button(action: {
                        withAnimation(.easeOut(duration: 0.2)) {
                            chosen = element
                            ishovered = true
                        }
                    }, label: {
                        Text(element)
                            .padding(.horizontal,15)
                            .padding(.vertical,5)
                            .scaleEffect((ishovered && hoveredText == element) ? 1.05: 1)
                        
                    }).buttonStyle(NeumorphicButtonStyle())
                    .onHover(perform: { hovering in
                        withAnimation(.easeInOut(duration: 0.1)){
                            ishovered = hovering
                            hoveredText = element
                        }
                    })
                    
                    GeometryReader{ geometry in
                        if (chosen == element){
                            VStack(alignment : .center){
                            RoundedRectangle(cornerRadius: 1.5)
                                .matchedGeometryEffect(id: "geoeffect1", in: nspace, properties : .frame)
                                .frame(width: geometry.size.width - ( (ishovered && hoveredText == element) ? 20 : 0) , height: 3,alignment: .center)
                            }.frame(width : geometry.size.width)
                        }
                    }
                    
                }.fixedSize(horizontal: true, vertical: false)
            }
            Spacer().background(Color.red)
        }.frame(maxWidth : .infinity)
    }
}

struct NeumorphicButtonStyle: ButtonStyle {
    @State var ishovered = false
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.05: 1)
            .contentShape(Rectangle())
            .foregroundColor(.primary)
            .animation(.spring())
            .onHover(perform: { hovering in
                print("hovering")
                ishovered = true
            })
        

    }
}

