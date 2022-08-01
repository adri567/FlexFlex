//
//  FlexPopup.swift
//  
//
//  Created by Adrian Suthold on 18.07.22.
//

import SwiftUI

public struct FlexPopup<Content: View>: View {
    
    // MARK: Propertys
    private var startingOffsetY: CGFloat = UIScreen.main.bounds.height
    private var bottomPopupOffset: CGFloat = 0.1                                                                // Offset from the button edge
    private var endingOffsetY: CGFloat {
        return startingOffsetY * abs((((popupHeight / startingOffsetY) + bottomPopupOffset) - 1.0))             // Calculates the ending offset
    }
    var closeOnTap: Bool
    let content: Content
    
    @State private var popupHeight: CGFloat = 0.0
    @Binding var presenting: Bool
    
    public init(
        @ViewBuilder _ content: @escaping() -> Content,
        presenting: Binding<Bool>,
        closeOnTap: Bool = false
    ) {
        self.content = content()
        self._presenting = presenting
        self.closeOnTap = closeOnTap
    }
    
    // MARK: Body
    public var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(presenting ? 0.5 : 0)
                .ignoresSafeArea()
                .animation(.default, value: presenting)
                .onTapGesture {
                    if closeOnTap {
                        presenting.toggle()
                    }
                }
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(height: popupHeight)
                    .padding(.horizontal, 16)
                    .overlay(
                        content
                            .padding(16)
                            .overlay(
                                GeometryReader { geo in
                                    Color
                                        .clear
                                        .preference(key: ContentHeightPreferenceKey.self, value: geo.size.height)
                                }
                            )
                    )
                    .onPreferenceChange(ContentHeightPreferenceKey.self, perform: { value in
                        DispatchQueue.main.async {
                            self.popupHeight = value
                            print(popupHeight)
                        }
                    })
                    .offset(y: presenting ? endingOffsetY : startingOffsetY)
                    .animation(.spring(), value: presenting)
                Spacer()
            }
        }
    }
}

struct FlexPopup_Previews: PreviewProvider {
    
    static private var test: some View {
        VStack {
            Text("JEllo")
            Text("JEllo")
        }
        .frame(height: 50)
    }
    
    static var previews: some View {
        FlexPopup({
//            Button {
//                print("hello")
//            } label: {
//                Text("HEllo")
//            }
//            .buttonStyle(.plain)
            test
        }, presenting: .constant(true))
    }
}
