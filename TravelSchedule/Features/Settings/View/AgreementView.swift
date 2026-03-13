import SwiftUI
import Combine

struct AgreementView: View {

    // MARK: - Private Properties

    private let viewModel = AgreementViewModel()
    @Environment(\.dismiss) private var dismiss

    // MARK: - Visual Components

    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                header
                scrollContent
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarHidden(true)
    }

    private var header: some View {
        NavigationHeaderView(
            title: "Пользовательское соглашение",
            showBackButton: true,
            backAction: { dismiss() }
        )
        .padding(.vertical, 11)
        .background(.whiteTS)
    }

    private var scrollContent: some View {
        ScrollView {
            mainContent
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
        }
        .background(.whiteTS)
    }

    private var mainContent: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text(viewModel.title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.blackTS)
                .multilineTextAlignment(.leading)

            Text(viewModel.introText)
                .font(.system(size: 17))
                .kerning(-0.41)
                .foregroundColor(.blackTS)
                .fixedSize(horizontal: false, vertical: true)

            Text(viewModel.termsTitle)
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 16)

            Text(viewModel.termsText)
                .font(.system(size: 17))
                .kerning(-0.41)
                .foregroundColor(.blackTS)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview

#Preview {
    AgreementView()
        .preferredColorScheme(.light)
}
