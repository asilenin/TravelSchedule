import SwiftUI
struct CarrierInfoView: View {
    
    @StateObject private var viewModel: CarrierInfoViewModel
    
    @Environment(\.dismiss) var dismiss
    
    init(carrier: CarrierInfo) {
        _viewModel = StateObject(wrappedValue: CarrierInfoViewModel(carrier: carrier))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            navigationHeader
            ScrollView {
                VStack(spacing: 0) {
                    carrierLogoView
                    carrierFullNameView
                    carrierEmailBlock
                    Spacer()
                    carrierPhoneBlock
                    Spacer()
                        .padding(.bottom, 50)
                }
            }
        }
        .background(Color(.whiteTS).ignoresSafeArea())
        .navigationBarHidden(true)
    }
    
    private var navigationHeader: some View {
        NavigationView(title: "Информация о перевозчике", showBackButton: true, backAction: {
            dismiss()
        })
    }
    
    private var carrierLogoView: some View {
        VStack {
            if let url = URL(string: viewModel.carrierLogoName), !viewModel.carrierLogoName.isEmpty {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure(_):
                        placeholderLogo
                    case .empty:
                        ProgressView()
                    @unknown default:
                        placeholderLogo
                    }
                }
                .frame(width: 343, height: 104)
                .padding(.top, 16)
            } else {
                placeholderLogo
                    .frame(width: 343, height: 104)
                    .padding(.top, 16)
            }
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
    }
    
    private var placeholderLogo: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
            Text(String(viewModel.carrierFullName.prefix(1)))
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.gray)
        }
    }
    
    
    private var carrierFullNameView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(viewModel.carrierFullName)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.blackTS)
                .padding(.top, 16)
                .padding(.bottom, 16)
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var carrierEmailBlock: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("E-mail")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.blackTS)
                .kerning(-0.41)
            Text(viewModel.email)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.blueUniversalTS)
                .kerning(0.4)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 60)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private var carrierPhoneBlock: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Телефон")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.blackTS)
                .kerning(-0.41)
            Text(viewModel.phone)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.blueUniversalTS)
                .kerning(0.4)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 60)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    if let carrier = CarrierInfo.carrier.first {
        CarrierInfoView(carrier: carrier)
    }
}
