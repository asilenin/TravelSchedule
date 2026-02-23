import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled: Bool = false
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Toggle("Тёмная тема", isOn: $isDarkModeEnabled)
                                .font(.system(size: 17))
                                .kerning(-0.41)
                                .tint(.blueUniversalTS)
                        }
                        .padding(.vertical, 19)
                        .padding(.horizontal, 16)
                        .background(.whiteTS)
                        NavigationLink {
                            AgreementView()
                        } label: {
                            HStack {
                                Text("Пользовательское соглашение")
                                    .font(.system(size: 17))
                                    .kerning(-0.41)
                                Spacer()
                                Image(.chevronForward)
                                    .foregroundColor(.blackTS)
                            }
                            .contentShape(Rectangle())
                            .padding(.vertical, 19)
                            .padding(.horizontal, 16)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                            .frame(height: 32)
                        
                    }
                    .background(.whiteTS)
                    .frame(maxWidth: .infinity)
                }
                Spacer()
                
                VStack(spacing: 16) {
                    Text("Приложение использует API «Яндекс.Расписания»")
                        .font(.system(size: 12))
                        .foregroundStyle(.blackTS)
                        .kerning(0.4)
                    Text("Версия 1.0 (beta)")
                        .font(.system(size: 12))
                        .foregroundStyle(.blackTS)
                        .kerning(0.4)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 24)
            }
            .background(.whiteTS)
        }
    }
}

#Preview {
    SettingsView()
}
