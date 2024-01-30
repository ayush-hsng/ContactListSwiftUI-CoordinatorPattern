//
//  TestView.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 30/01/24.
//

import SwiftUI

struct DragGestureTestView: View {
    @State private var sheetHeight: CGFloat = 200
    @GestureState private var draggingState: CGFloat = 0
    @State private var presentBottomSheet: Bool = false
    var body: some View {
        ZStack {
            Color.yellow
            Button {
                withAnimation {
                    self.presentBottomSheet.toggle()
                }
            } label: {
                Text("Custom Bottom Sheet")
                    .font(.title)
                    .foregroundStyle(.black)
                    .padding()
                    .background(.green.opacity(0.8), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            if self.presentBottomSheet {
                VStack {
                    Color.black.opacity(0.3)
                    VStack {
                        Text("Sheet Height: \(Int(sheetHeight))")
                            .padding()
                    }
                    .frame(height: sheetHeight)
                    
                }
            }
        }.gesture(
            DragGesture()
                .updating($draggingState, body: { (value, state, transaction) in
                    state = value.translation.height
                    let newHeight = self.sheetHeight - state
                    self.sheetHeight = newHeight
                })
                .onEnded { value in
                    withAnimation {
                        let newHeight = self.sheetHeight - value.translation.height
                        self.sheetHeight = newHeight
                    }
                }
        )
    }
}



#Preview(body: {
    DragGestureTestView()
})
