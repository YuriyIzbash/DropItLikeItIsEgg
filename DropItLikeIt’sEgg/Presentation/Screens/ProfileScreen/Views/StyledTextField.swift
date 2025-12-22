//
//  StyledTextField.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import SwiftUI

struct StyledTextField: View {
    let title: String
    @Binding var text: String
    let field: ProfileScreenVM.Field
    @FocusState.Binding var focusedField: ProfileScreenVM.Field?
    var isError: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color.appPink)
            
            HStack(spacing: 12) {
                ZStack(alignment: .leading) {
                    if text.isEmpty && focusedField != field {
                        Text(title)
                            .customFont(size: 16)
                            .foregroundStyle(isError ? Color.red : Color.white)
                    }
                    
                    TextField("", text: $text)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .customFont(size: 16)
                        .tint(.white)
                        .focused($focusedField, equals: field)
                }
                
                Image(systemName: "square.and.pencil")
                    .foregroundStyle(Color.white.opacity(0.9))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
        }
        .frame(height: 48)
    }
}
