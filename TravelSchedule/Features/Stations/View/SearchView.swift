import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.grayUniversalTS)
                
            TextField("Введите запрос", text: $searchText)
                .font(.system(size: 17))
                .foregroundColor(.blackUniversalTS)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            
            if !searchText.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.grayUniversalTS)
                    .onTapGesture {
                        searchText = ""
                    }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.lightGrayUniversalTS)
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}
