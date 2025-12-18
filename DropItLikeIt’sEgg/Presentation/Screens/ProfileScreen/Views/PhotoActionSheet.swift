//
//  PhotoActionSheet.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import SwiftUI

struct PhotoActionSheet: View {
    @Binding var isPresented: Bool
    let onMakePhoto: () -> Void
    let onChoosePhoto: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            if isPresented {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isPresented = false
                        }
                    
                    VStack {
                        Spacer()
                        
                        VStack {
                            Text("PLEASE MAKE YOUR CHOICE")
                                .font(.sheetText)
                                .appTextStyle()
                                .padding()
                                
                            Divider()
                                .background(Color.white)
                                .padding(.bottom, 16)
                            
                            VStack {
                                Button {
                                    isPresented = false
                                    DispatchQueue.main.async {
                                        onMakePhoto()
                                    }
                                } label: {
                                    Text("MAKE A PHOTO")
                                }
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.black)
                                
                                Button {
                                    isPresented = false
                                    DispatchQueue.main.async {
                                        onChoosePhoto()
                                    }
                                } label: {
                                    Text("CHOOSE PHOTO")
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: 44)
                                .foregroundColor(.black)
                                .font(.sheetText)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(12)
                            .padding(.horizontal, 56)
                            .padding(.bottom, 16)
                           
                            Button {
                                isPresented = false
                            } label: {
                                Text("CANCEL")
                                    .frame(maxWidth: .infinity, maxHeight: 44)
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .font(.sheetText)
                                    .cornerRadius(12)
                                    .padding(.horizontal, 104)
                            }
                        }
                        .padding(.bottom, geometry.safeAreaInsets.bottom)
                        .frame(height: geometry.size.height * 0.35)
                        .background(Color.sheetBackground)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                    }
                    .ignoresSafeArea(edges: .bottom)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.easeInOut(duration: 0.2), value: isPresented)
            }
        }
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = 0
    var corners: UIRectCorner = []
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

private extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct PreviewWrapper: View {
    @State private var showSheet = false
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            Button("Show PhotoActionSheet") {
                showSheet = true
            }
            PhotoActionSheet(isPresented: $showSheet, onMakePhoto: {
                print("Make Photo tapped")
            }, onChoosePhoto: {
                print("Choose Photo tapped")
            })
        }
    }
}

#Preview {
    PreviewWrapper()
}
