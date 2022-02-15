import SwiftUI

struct StatsView: View {
    let percentage: Int
    let points: Int

    var body: some View {
        HStack {
            ZStack {
                RingShape(percent: 100, startAngle: -90, drawnClockwise: false)
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .fill(Color.box)
                    .frame(width: 60, height: 60)
                RingShape(percent: Double(percentage), startAngle: -90, drawnClockwise: false)
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .fill(Color.accentColor)
                    .frame(width: 60, height: 60)
                Text("\(percentage)%")
                    .foregroundColor(.white)
                    .font(.custom("PalameciaTitling-Regular", size: 16))
                    .minimumScaleFactor(0.01)
                    .foregroundColor(.white)
            }
            VStack(alignment: .leading) {
                Text("Els teus punts")
                    .foregroundColor(.white)
                    .font(.custom("PalameciaTitling-Regular", size: 28))
                    .minimumScaleFactor(0.01)
                    .foregroundColor(.white)
                Text("\(points)")
                    .foregroundColor(.white)
                    .font(.custom("PalameciaTitling-Regular", size: 20))
                    .minimumScaleFactor(0.01)
                    .foregroundColor(.white)
            }
            .padding(.leading, 10)
            
        }
        .padding(.bottom, 15)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(percentage: 60, points: 10)
    }
}
