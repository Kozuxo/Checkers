import SwiftUI
import AVFoundation


struct mainmenu: View {
    @State private var MainScreen = false
      @State private var komputermode = false
      @State private var sekarang:gamemode = .pvp
      @State private var jarakgerak: Double = 50
      @State private var transparan: Double = 1
   
    var body: some View {
        ZStack {
            Image("checker")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .offset(x: -24.9, y: 0)
                
        VStack(spacing: 10){
            
            Image("checkers")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 300)
            
            VStack(){
            Button(action: {MainScreen = true;
                sekarang = .pvp
                               
                                }, label: {
                      Image("VS PLAYER")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 100)
                                        
                                        
                                }) .fullScreenCover(isPresented: $MainScreen, content:{ContentView(MainScreen: $MainScreen, sekarang: $sekarang )})
            Button(action: { komputermode = true;
                sekarang = .pve
                               
                                }, label: {
                         Image("VS COMPUTER")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 250, height: 100)
                                    
                                }).fullScreenCover(isPresented: $komputermode, content:{home(komputermode: $komputermode, sekarang: $sekarang)})
            }
                   
        }
    
    }
}
}

struct mainmenuview: PreviewProvider {
    static var previews: some View {
        mainmenu()
    }
}
