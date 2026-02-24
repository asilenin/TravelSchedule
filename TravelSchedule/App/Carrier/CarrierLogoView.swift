import SwiftUI

struct CarrierLogoView: View {
    
    let logoName: String
    let carrierName: String
    let transfer: String?
    
    var body: some View {
        HStack(spacing: 8) {
            logoImage
            carrierInfo
        }
    }
    
    private  var logoImage: some View {
        Image(logoName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 38, height: 38)
            .cornerRadius(12)
    }
    
    private var carrierInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(carrierName)
                .font(.system(size: 17, weight: .regular))
                .kerning(-0.41)
                .foregroundColor(.blackUniversalTS)
            
            if let transfer = transfer {
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
            logoName: "UralLogisktikaLogo",
            carrierName: "Урал логистика",
            transfer: "С пересадкой в Костроме"
        )
        .padding()
    }
    .background(.grayUniversalTS)
}
