import SwiftUI

struct CarrierLogoView: View {
    let logoURL: String?
    let carrierName: String
    let transfer: String?
    
    var body: some View {
        HStack(spacing: 8) {
            logoImage
            carrierInfo
        }
    }
    
    private var logoImage: some View {
        Group {
            if let url = validURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 38, height: 38)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 38, height: 38)
                            .cornerRadius(12)
                    case .failure:
                        placeholder
                    @unknown default:
                        placeholder
                    }
                }
            } else {
                placeholder
            }
        }
    }
    
    private var placeholder: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 38, height: 38)
            
            Text(String(carrierName.prefix(1)))
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.blackUniversalTS)
        }
    }
    
    private var validURL: URL? {
        guard
            let logoURL,
            !logoURL.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            let url = URL(string: logoURL)
        else { return nil }
        
        return url
    }
    
    private var carrierInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(carrierName)
                .font(.system(size: 17, weight: .regular))
                .kerning(-0.41)
                .foregroundColor(.blackUniversalTS)
            
            if let transfer = transfer, !transfer.isEmpty {
                Text(transfer)
                    .font(.system(size: 12, weight: .regular))
                    .kerning(0.4)
                    .foregroundColor(.redUniversalTS)
            }
        }
    }
}

#Preview {
    List
    {
        CarrierLogoView(
            logoURL: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif",
            carrierName: "Урал логистика",
            transfer: "С пересадкой в Костроме"
        )
        .padding()
    }
    .background(.grayUniversalTS)
}
