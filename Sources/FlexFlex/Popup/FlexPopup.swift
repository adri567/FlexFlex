//
//  FlexPopup.swift
//  
//
//  Created by Adrian Suthold on 18.07.22.
//

import SwiftUI

public enum Position {
    case bottom, center, top
}

public struct FlexPopup<Content: View>: View {
    
    // MARK: Properties
    private var startingOffsetY: CGFloat = UIScreen.main.bounds.height
    private var safeAreaOffset: CGFloat = 44           // SafeArea offset
    private var bottomEndingOffsetY: CGFloat {
        return startingOffsetY - popupHeight - safeAreaOffset
    }
    private var centerEndingoffsetY: CGFloat {
        return startingOffsetY / 2 - (popupHeight / 2)
    }
    private var topEndingoffsetY: CGFloat {
        return startingOffsetY / popupHeight + safeAreaOffset
    }
    @State private var popupHeight: CGFloat = 0.0
    
    let content: Content
    @Binding var presenting: Bool
    let position: Position
    let closeOnTap: Bool
    
    public init(
        @ViewBuilder _ content: @escaping() -> Content,
        presenting: Binding<Bool>,
        position: Position,
        closeOnTap: Bool = false
    ) {
        self.content = content()
        self._presenting = presenting
        self.position = position
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
                        }
                    })
                    .offset(y: presenting ? offset(from: position) :
                                position == .top ? -popupHeight : startingOffsetY)
                    .animation(.spring(), value: presenting)
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
    
    // MARK: - Methods
    private func offset(from position: Position) -> CGFloat {
        switch position {
        case .bottom:
            return bottomEndingOffsetY
        case .center:
            return centerEndingoffsetY
        case .top:
            return topEndingoffsetY
        }
    }
}

struct FlexPopup_Previews: PreviewProvider {
    
    static private var test: some View {
        VStack {
            Text("JEllo")
            //            Text("JEllo")
            //            Text("JEllo")
            //            Text("JEllo")
            //            Text("JEllo")
            //            Text("JEllo")
            //            Text("JEllo")
        }
        //        .frame(height: 50)
    }
    
    static var previews: some View {
        ZStack {
            Text("Hell9")
            FlexPopup({
                //            Button {
                //                print("hello")
                //            } label: {
                //                Text("HEllo")
                //            }
                //            .buttonStyle(.plain)
                test
            }, presenting: .constant(true), position: .bottom)
            .opacity(0.4)
        }
        .previewDevice("iPhone 8")
    }
}
