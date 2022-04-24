
import SwiftUI
import AVFoundation

struct ContentView: View {
    enum giliransiapa{
        case orange, blue
    }
    @Binding var MainScreen:Bool
    @Binding var sekarang:gamemode
    @State var bulet:[[bulets]] = Array(repeating: Array(repeating: bulets(), count: 8), count: 8)
    @State var giliran:giliransiapa = .blue
    @State var heal = [coordinate]()
    @State var musuh = [coordinate]()
    @State var tukartempat = coordinate(x: 0, y: 0)
    @State var makan = [coordinate]()
    @State var mencari: Bool = false
    @State var warnaputih: Int = 12
    @State var warnahitam: Int = 12
    @State var menang: String = ""
    
    var body: some View {
        ZStack{
            Image("checker")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .offset(x: -24.9, y: 0)
        ScrollView {
            VStack{
                HStack {
                    Image("P1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                    
                    VStack {
                        HStack {
                            
                            Image("VS")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .padding(30)
                        
                        }
                    }
                    Image("P2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                }.padding(.leading, 10)
                .padding(.trailing, 10)
                  
         
                
               ZStack{
                   VStack(alignment: .center, spacing: 0.0) {
                       ForEach(0..<8) { i in
                           HStack(spacing: 0.0) {
                               ForEach(0..<8) { j in
                                   Rectangle()
                                       .frame(width: 50, height: 50)
                                       .foregroundColor(warnamap(i: i, j: j))
                               }
                           }
                       }
                   }
                   ZStack{
                       VStack(alignment: .center) {
                           ForEach(0..<8) { i in
                               HStack {
                                   ForEach(0..<8) { j in
                                       Circle()
                                           .stroke(warnapilih(x: i, y: j),lineWidth:8)
                                           .frame(width: 42, height: 42)
                                           .opacity(pilihan(x: i, y: j))
                                   }
                               }
                           }
                       }
                       VStack(alignment: .center) {
                           ForEach(0..<8) { i in
                               HStack {
                                   ForEach(0..<8) { j in
                                       Circle()
                                           .frame(width: 42, height: 42)
                                           .foregroundColor(bulet[i][j].color)
                                           .opacity(bulet[i][j].transparan)
                                           .onTapGesture {
                                               checkselect(i: i, j: j)
                                           }
                                   }
                               }
                           }
                       }
                       VStack(alignment: .center) {
                           ForEach(0..<8) { i in
                               HStack {
                                   ForEach(0..<8) { j in
                                       Image("crown")
                                           .resizable()
                                           .padding(.all, 13.0)
                                           .scaledToFill()
                                           .frame(width: 42, height: 42)
                                           .opacity(raja(i: i, j: j))
                                   }
                               }
                           }
                       }
                       VStack{
                           if menang != ""{
                               if menang == "P2 Win"{
                                   Button {
                                   MainScreen = false
                                   } label: {
                                       Image("P1WIN")
                                           .resizable()
                                           .scaledToFill()
                                           .frame(width: 200, height: 100)
                                   }
                           }
                               else{
                                   Button {
                                   MainScreen = false
                                   } label: {
                                       Image("P2WIN")
                                           .resizable()
                                           .scaledToFill()
                                           .frame(width: 200, height: 100)
                                   }
                               }
                       }
                       
                   }
                   }
                   
               }
                HStack{
                    Button(action: {MainScreen = false}, label: {
                        
                        Image("rumah")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90,height:70)
                            .padding(60)
                        
                    })
                Button {
                       startawal()
                   } label: {
                       Image("STARTS")
                           .resizable()
                           .scaledToFill()
                           .frame(width: 90, height: 70)
                           .padding(60)
                   }
            }
           }
        
        }
    }
    }

    func warnamap(i:Int, j:Int)->Color{
            if i % 2 == 0{
                if j % 2 == 0{
                    return Color.gray
                }
                else{
                    return Color.black
                }
            }
            else{
                if j % 2 == 0{
                    return Color.black
                }
                else{
                    return Color.gray
                }
            }
        }
        
        func startawal(){
            bulet = Array(repeating: Array(repeating: bulets(), count: 8), count: 8)
            giliran = .blue
            heal = [coordinate]()
            musuh = [coordinate]()
            tukartempat = coordinate(x: 0, y: 0)
            makan = [coordinate]()
            mencari = false
            warnaputih = 12
            warnahitam = 12
            menang = ""
            for i in 0...7{
                for j in 0...7{
                        if i < 3{
                            if i % 2 == 0{
                                if j % 2 == 0{
                                    bulet[i][j].color = Color.orange
                                    bulet[i][j].transparan = 1
                                }
                            }
                            else{
                                if j % 2 == 1{
                                    bulet[i][j].color = Color.orange
                                    bulet[i][j].transparan = 1
                                }
                            }
                        }
                        else if i > 4{
                            if i % 2 == 0{
                                if j % 2 == 0{
                                    bulet[i][j].color = Color.blue
                                    bulet[i][j].transparan = 1
                                }
                            }
                            else{
                                if j % 2 == 1{
                                    bulet[i][j].color = Color.blue
                                    bulet[i][j].transparan = 1
                                }
                            }
                        }
                    }
                }
        }
        
        func warnapilih(x:Int, y:Int) -> Color{
            if bulet[x][y].dipilih == true{
                return Color.red
            }
            else{
                return bulet[x][y].color
            }
        }
        func pilihan(x:Int, y:Int) -> Double{
            if bulet[x][y].dipilih == true{
                return 1
            }
            else{
                return 0
            }
        }
        func posisiterkam(){
            for he in heal{
                if bulet[he.x][he.y].transparan == 0.3{
                    bulet[he.x][he.y].transparan = 0
                    bulet[he.x][he.y].color = Color.red
                }
            }
            heal = [coordinate]()
        }
        func posisiterkam(i:Int, j:Int, warnagiliran:Color, enemycolor: Color){
            if bulet[i][j].color == Color.orange{
                if bulet[i][j].rajas == false{
                    if i + 2 < 8 && j - 2 >= 0 && bulet[i+1][j-1].color == enemycolor && bulet[i+2][j-2].transparan == 0{
                        bulet[i+2][j-2].color = warnagiliran
                        bulet[i+2][j-2].transparan = 0.3
                        musuh.append(coordinate(x: i+2, y: j-2))
                    }
                    if i + 2 < 8 && j + 2 < 8 && bulet[i+1][j+1].color == enemycolor && bulet[i+2][j+2].transparan == 0{
                        bulet[i+2][j+2].color = warnagiliran
                        bulet[i+2][j+2].transparan = 0.3
                        musuh.append(coordinate(x: i+2, y: j+2))
                    }
                }
                else{
                    if i - 2 >= 0 && j - 2 >= 0 && bulet[i-1][j-1].color == enemycolor && bulet[i-2][j-2].transparan == 0{
                        bulet[i-2][j-2].color = warnagiliran
                        bulet[i-2][j-2].transparan = 0.3
                        musuh.append(coordinate(x: i-2, y: j-2))
                    }
                    if i - 2 >= 0 && j + 2 < 8 && bulet[i-1][j+1].color == enemycolor && bulet[i-2][j+2].transparan == 0{
                        bulet[i-2][j+2].color = warnagiliran
                        bulet[i-2][j+2].transparan = 0.3
                        musuh.append(coordinate(x: i-2, y: j+2))
                    }
                    if i + 2 < 8 && j - 2 >= 0 && bulet[i+1][j-1].color == enemycolor && bulet[i+2][j-2].transparan == 0{
                        bulet[i+2][j-2].color = warnagiliran
                        bulet[i+2][j-2].transparan = 0.3
                        musuh.append(coordinate(x: i+2, y: j-2))
                    }
                    if i + 2 < 8 && j + 2 < 8 && bulet[i+1][j+1].color == enemycolor && bulet[i+2][j+2].transparan == 0{
                        bulet[i+2][j+2].color = warnagiliran
                        bulet[i+2][j+2].transparan = 0.3
                        musuh.append(coordinate(x: i+2, y: j+2))
                    }
                }
            }
            else if bulet[i][j].color == Color.blue{
                if bulet[i][j].rajas == false{
                    if i - 2 >= 0 && j - 2 >= 0 && bulet[i-1][j-1].color == enemycolor && bulet[i-2][j-2].transparan == 0{
                        bulet[i-2][j-2].color = warnagiliran
                        bulet[i-2][j-2].transparan = 0.3
                        musuh.append(coordinate(x: i-2, y: j-2))
                    }
                    if i - 2 >= 0 && j + 2 < 8 && bulet[i-1][j+1].color == enemycolor && bulet[i-2][j+2].transparan == 0{
                        bulet[i-2][j+2].color = warnagiliran
                        bulet[i-2][j+2].transparan = 0.3
                        musuh.append(coordinate(x: i-2, y: j+2))
                    }
                }
                else{
                    if i - 2 >= 0 && j - 2 >= 0 && bulet[i-1][j-1].color == enemycolor && bulet[i-2][j-2].transparan == 0{
                        bulet[i-2][j-2].color = warnagiliran
                        bulet[i-2][j-2].transparan = 0.3
                        musuh.append(coordinate(x: i-2, y: j-2))
                    }
                    if i - 2 >= 0 && j + 2 < 8 && bulet[i-1][j+1].color == enemycolor && bulet[i-2][j+2].transparan == 0{
                        bulet[i-2][j+2].color = warnagiliran
                        bulet[i-2][j+2].transparan = 0.3
                        musuh.append(coordinate(x: i-2, y: j+2))
                    }
                    if i + 2 < 8 && j - 2 >= 0 && bulet[i+1][j-1].color == enemycolor && bulet[i+2][j-2].transparan == 0{
                        bulet[i+2][j-2].color = warnagiliran
                        bulet[i+2][j-2].transparan = 0.3
                        musuh.append(coordinate(x: i+2, y: j-2))
                    }
                    if i + 2 < 8 && j + 2 < 8 && bulet[i+1][j+1].color == enemycolor && bulet[i+2][j+2].transparan == 0{
                        bulet[i+2][j+2].color = warnagiliran
                        bulet[i+2][j+2].transparan = 0.3
                        musuh.append(coordinate(x: i+2, y: j+2))
                    }
                }
            }
        }
    
        func highlight(){
            for mu in musuh{
                bulet[mu.x][mu.y].transparan = 0
                bulet[mu.x][mu.y].color = Color.red
            }
            musuh = [coordinate]()
        }
        func gapilih(x:Int, y:Int){
            for i in 0...7{
                for j in 0...7{
                    if i == x && j == y{
                        bulet[i][j].dipilih = true
                    }
                    else{
                        bulet[i][j].dipilih = false
                    }
                }
            }
        }
        func makankosong(){
            makan = [coordinate]()
        }
        
        func checkmakan(mycolor:Color,opcolor:Color){
            for i in 0...7{
                for j in 0...7{
                    if mycolor == Color.orange && bulet[i][j].color == mycolor{
                        var tmp_index = 0
                        if bulet[i][j].rajas == false{
                            if i + 2 < 8 && j - 2 >= 0 && bulet[i+1][j-1].color == opcolor && bulet[i+1][j-1].transparan == 1 && bulet[i+2][j-2].transparan == 0{
                                tmp_index = 1
                            }
                            if i + 2 < 8 && j + 2 < 8 && bulet[i+1][j+1].color == opcolor && bulet[i+1][j+1].transparan == 1 && bulet[i+2][j+2].transparan == 0{
                                tmp_index = 1
                            }
                            if tmp_index == 1{
                                makan.append(coordinate(x: i, y: j))
                            }
                        }
                        else{
                            if i + 2 < 8 && j - 2 >= 0 && bulet[i+1][j-1].color == opcolor && bulet[i+1][j-1].transparan == 1  && bulet[i+2][j-2].transparan == 0{
                                tmp_index = 1
                            }
                            if i + 2 < 8 && j + 2 < 8 && bulet[i+1][j+1].color == opcolor && bulet[i+1][j+1].transparan == 1  && bulet[i+2][j+2].transparan == 0{
                                tmp_index = 1
                            }
                            if i - 2 >= 0 && j - 2 >= 0 && bulet[i-1][j-1].color == opcolor && bulet[i-1][j-1].transparan == 1  && bulet[i-2][j-2].transparan == 0{
                                tmp_index = 1
                            }
                            if i - 2 >= 0 && j + 2 < 8 && bulet[i-1][j+1].color == opcolor && bulet[i-1][j+1].transparan == 1  && bulet[i-2][j+2].transparan == 0{
                                tmp_index = 1
                            }
                            if tmp_index == 1{
                                makan.append(coordinate(x: i, y: j))
                            }
                        }
                    }
                    else if mycolor == Color.blue && bulet[i][j].color == mycolor{
                        var tmp_index = 0
                        if bulet[i][j].rajas == false{
                            if i - 2 >= 0 && j - 2 >= 0 && bulet[i-1][j-1].color == opcolor && bulet[i-1][j-1].transparan == 1  && bulet[i-2][j-2].transparan == 0{
                                tmp_index = 1
                            }
                            if i - 2 >= 0 && j + 2 < 8 && bulet[i-1][j+1].color == opcolor && bulet[i-1][j+1].transparan == 1  && bulet[i-2][j+2].transparan == 0{
                                tmp_index = 1
                            }
                            if tmp_index == 1{
                                makan.append(coordinate(x: i, y: j))
                            }
                        }
                        else{
                            if i + 2 < 8 && j - 2 >= 0 && bulet[i+1][j-1].color == opcolor && bulet[i+1][j-1].transparan == 1  && bulet[i+2][j-2].transparan == 0{
                                tmp_index = 1
                            }
                            if i + 2 < 8 && j + 2 < 8 && bulet[i+1][j+1].color == opcolor && bulet[i+1][j+1].transparan == 1  && bulet[i+2][j+2].transparan == 0{
                                tmp_index = 1
                            }
                            if i - 2 >= 0 && j - 2 >= 0 && bulet[i-1][j-1].color == opcolor && bulet[i-1][j-1].transparan == 1  && bulet[i-2][j-2].transparan == 0{
                                tmp_index = 1
                            }
                            if i - 2 >= 0 && j + 2 < 8 && bulet[i-1][j+1].color == opcolor && bulet[i-1][j+1].transparan == 1  && bulet[i-2][j+2].transparan == 0{
                                tmp_index = 1
                            }
                            if tmp_index == 1{
                                makan.append(coordinate(x: i, y: j))
                            }
                        }
                    }
                }
            }
        }
        func warnaplayer(color:Color)->giliransiapa{
            if color == Color.orange{
                return .orange
            }
            else{
                return .blue
            }
        }
        
        func warnamenang(){
            if warnahitam == 0{
                menang = "P2 Win"
            }
            if warnaputih == 0{
                menang = "P1 Win"
            }
        }
        func checkgerak(color:Color)->Bool{
            for i in 0...7{
                for j in 0...7{
                    if color == Color.orange{
                        if bulet[i][j].rajas == false{
                            if i + 1 < 8 && (j - 1 >= 0 || j + 1 < 8){
                                if j - 1 >= 0 && bulet[i + 1][j - 1].transparan == 0{
                                    return true
                                }
                                 if j + 1 < 8 && bulet[i + 1][j + 1].transparan == 0{
                                    return true
                                }
                            }
                        }
                        else{
                            if (i + 1 < 8 || i - 1 >= 0) && (j - 1 >= 0 || j + 1 < 8 ){
                                if j - 1 >= 0 && i + 1 < 8 && bulet[i + 1][j - 1].transparan == 0{
                                    return true
                                }
                                 if j + 1 < 8 && i + 1 < 8 && bulet[i + 1][j + 1].transparan == 0{
                                    return true
                                 }
                                if j - 1 >= 0 && i - 1 >= 0 && bulet[i - 1][j - 1].transparan == 0{
                                    return true
                                }
                                if j + 1 < 8 && i - 1 >= 0 && bulet[i - 1][j + 1].transparan == 0{
                                   return true
                                }
                            }
                        }
                    }
                    else{
                        if bulet[i][j].rajas == false{
                            if i - 1 >= 0 && (j - 1 >= 0 || j + 1 < 8){
                                if j - 1 >= 0 && bulet[i - 1][j - 1].transparan == 0{
                                    return true
                                }
                                 if j + 1 < 8 && bulet[i - 1][j + 1].transparan == 0{
                                    return true
                                }
                            }
                        }
                        else{
                            if (i + 1 < 8 || i - 1 >= 0) && (j - 1 >= 0 || j + 1 < 8 ){
                                if j - 1 >= 0 && i + 1 < 8 && bulet[i + 1][j - 1].transparan == 0{
                                    return true
                                }
                                 if j + 1 < 8 && i + 1 < 8 && bulet[i + 1][j + 1].transparan == 0{
                                    return true
                                 }
                                if j - 1 >= 0 && i - 1 >= 0 && bulet[i - 1][j - 1].transparan == 0{
                                    return true
                                }
                                if j + 1 < 8 && i - 1 >= 0 && bulet[i - 1][j + 1].transparan == 0{
                                   return true
                                }
                            }
                        }
                    }
                }
            }
            return false
        }
        
    func warnaterkam(){
        for he in heal{
            if bulet[he.x][he.y].transparan == 0.3{
                bulet[he.x][he.y].transparan = 0
                bulet[he.x][he.y].color = Color.red
            }
        }
        heal = [coordinate]()
    }
    
        func checkselect(i:Int, j:Int){
            var warnagiliran: Color
            var enemycolor: Color
            switch giliran{
            case.orange:
                warnagiliran = Color.orange
            case.blue:
                warnagiliran = Color.blue
            }
            if warnagiliran == Color.orange{
                enemycolor = Color.blue
            }
            else{
                enemycolor = Color.orange
            }
            if checkgerak(color: warnagiliran)==false{
                if warnagiliran == Color.blue{
                    menang = "Orange"
                }
                else{
                    menang = "Blue"
                }
            }
            if makan.count != 0{
                for mu in makan{
                    bulet[mu.x][mu.y].dipilih = true
                }
                if bulet[i][j].dipilih == true && bulet[i][j].color == warnagiliran && mencari == false{
                    gapilih(x: i,y: j)
                    highlight()
                    tukartempat = coordinate(x: i, y: j)
                    posisiterkam(i: i, j: j, warnagiliran: warnagiliran, enemycolor: enemycolor)
                }
                else if bulet[i][j].transparan == 0.3 && bulet[i][j].color == warnagiliran{
                    highlight()
                    bulet[i][j].transparan = 1
                    bulet[i][j].color = warnagiliran
                    bulet[tukartempat.x][tukartempat.y].color = Color.red
                    bulet[tukartempat.x][tukartempat.y].transparan = 0
                    bulet[i][j].rajas = bulet[tukartempat.x][tukartempat.y].rajas
                    bulet[tukartempat.x][tukartempat.y].rajas = false
                    bulet[(tukartempat.x+i)/2][(tukartempat.y + j)/2].transparan = 0
                    bulet[(tukartempat.x+i)/2][(tukartempat.y + j)/2].rajas = false
                    if bulet[(tukartempat.x+i)/2][(tukartempat.y + j)/2].color == Color.orange{
                        warnahitam -= 1
                    }
                    else{
                        warnaputih -= 1
                    }
                    bulet[(tukartempat.x+i)/2][(tukartempat.y + j)/2].color = Color.red
                    warnamenang()
                    if bulet[i][j].color==Color.orange && i==7{
                        bulet[i][j].rajas = true
                    }
                    else if bulet[i][j].color==Color.blue && i==0{
                        bulet[i][j].rajas = true
                    }
                    posisiterkam(i: i, j: j, warnagiliran: warnagiliran, enemycolor: enemycolor)
                    if musuh.count == 0{
                        mencari = false
                        gapilih(x: -1, y: -1)
                        makankosong()
                        checkmakan(mycolor: enemycolor, opcolor: warnagiliran)
                        giliran = warnaplayer(color: enemycolor)
                    }
                    else{
                        tukartempat = coordinate(x: i, y: j)
                        gapilih(x: i, y: j)
                        mencari = true
                        makankosong()
                        makan.append(coordinate(x: i, y: j))
                    }
                }
            }
            else if bulet[i][j].color == warnagiliran && bulet[i][j].transparan == 1{
                bulet[tukartempat.x][tukartempat.y].dipilih = false
                bulet[i][j].dipilih = true
                warnaterkam()
                tukartempat = coordinate(x: i, y: j)
                if warnagiliran == Color.orange{
                    if bulet[i][j].rajas == false{
                        if i + 1 < 8 && (j - 1 >= 0 || j + 1 < 8){
                            if j - 1 >= 0 && bulet[i + 1][j - 1].transparan == 0{
                                bulet[i + 1][j - 1].transparan = 0.3
                                bulet[i + 1][j - 1].color = Color.orange
                                heal.append(coordinate(x: i + 1, y: j - 1))
                            }
                             if j + 1 < 8 && bulet[i + 1][j + 1].transparan == 0{
                                bulet[i + 1][j + 1].transparan = 0.3
                                bulet[i + 1][j + 1].color = Color.orange
                                heal.append(coordinate(x: i + 1, y: j + 1))
                            }
                        }
                    }
                    else{
                        if (i + 1 < 8 || i - 1 >= 0) && (j - 1 >= 0 || j + 1 < 8 ){
                            if j - 1 >= 0 && i + 1 < 8 && bulet[i + 1][j - 1].transparan == 0{
                                bulet[i + 1][j - 1].transparan = 0.3
                                bulet[i + 1][j - 1].color = Color.orange
                                heal.append(coordinate(x: i + 1, y: j - 1))
                            }
                             if j + 1 < 8 && i + 1 < 8 && bulet[i + 1][j + 1].transparan == 0{
                                bulet[i + 1][j + 1].transparan = 0.3
                                bulet[i + 1][j + 1].color = Color.orange
                                heal.append(coordinate(x: i + 1, y: j + 1))
                             }
                            if j - 1 >= 0 && i - 1 >= 0 && bulet[i - 1][j - 1].transparan == 0{
                                bulet[i - 1][j - 1].transparan = 0.3
                                bulet[i - 1][j - 1].color = Color.orange
                                heal.append(coordinate(x: i - 1, y: j - 1))
                            }
                            if j + 1 < 8 && i - 1 >= 0 && bulet[i - 1][j + 1].transparan == 0{
                               bulet[i - 1][j + 1].transparan = 0.3
                               bulet[i - 1][j + 1].color = Color.orange
                               heal.append(coordinate(x: i - 1, y: j + 1))
                            }
                        }
                    }
                }
                else{
                    if bulet[i][j].rajas == false{
                        if i - 1 >= 0 && (j - 1 >= 0 || j + 1 < 8){
                            if j - 1 >= 0 && bulet[i - 1][j - 1].transparan == 0{
                                bulet[i - 1][j - 1].transparan = 0.3
                                bulet[i - 1][j - 1].color = Color.blue
                                heal.append(coordinate(x: i - 1, y: j - 1))
                            }
                             if j + 1 < 8 && bulet[i - 1][j + 1].transparan == 0{
                                bulet[i - 1][j + 1].transparan = 0.3
                                bulet[i - 1][j + 1].color = Color.blue
                                heal.append(coordinate(x: i - 1, y: j + 1))
                            }
                        }
                    }
                    else{
                        if (i + 1 < 8 || i - 1 >= 0) && (j - 1 >= 0 || j + 1 < 8 ){
                            if j - 1 >= 0 && i + 1 < 8 && bulet[i + 1][j - 1].transparan == 0{
                                bulet[i + 1][j - 1].transparan = 0.3
                                bulet[i + 1][j - 1].color = Color.blue
                                heal.append(coordinate(x: i + 1, y: j - 1))
                            }
                             if j + 1 < 8 && i + 1 < 8 && bulet[i + 1][j + 1].transparan == 0{
                                bulet[i + 1][j + 1].transparan = 0.3
                                bulet[i + 1][j + 1].color = Color.blue
                                heal.append(coordinate(x: i + 1, y: j + 1))
                             }
                            if j - 1 >= 0 && i - 1 >= 0 && bulet[i - 1][j - 1].transparan == 0{
                                bulet[i - 1][j - 1].transparan = 0.3
                                bulet[i - 1][j - 1].color = Color.blue
                                heal.append(coordinate(x: i - 1, y: j - 1))
                            }
                            if j + 1 < 8 && i - 1 >= 0 && bulet[i - 1][j + 1].transparan == 0{
                               bulet[i - 1][j + 1].transparan = 0.3
                               bulet[i - 1][j + 1].color = Color.blue
                               heal.append(coordinate(x: i - 1, y: j + 1))
                            }
                        }
                    }
                }
            }
            else if bulet[i][j].color == warnagiliran && bulet[i][j].transparan == 0.3{
                bulet[i][j].transparan = 1
                bulet[tukartempat.x][tukartempat.y].color = Color.red
                bulet[tukartempat.x][tukartempat.y].dipilih = false
                bulet[i][j].rajas = bulet[tukartempat.x][tukartempat.y].rajas
                bulet[tukartempat.x][tukartempat.y].transparan = 0
                bulet[tukartempat.x][tukartempat.y].rajas = false
                if bulet[i][j].color==Color.orange && i==7{
                    bulet[i][j].rajas = true
                }
                else if bulet[i][j].color==Color.blue && i==0{
                    bulet[i][j].rajas = true
                }
                print(bulet[i][j].rajas)
                warnaterkam()
                giliran = warnaplayer(color: enemycolor)
                makankosong()
                checkmakan(mycolor: enemycolor, opcolor: warnagiliran)
            }

            if makan.count != 0{
                for mu in makan{
                    bulet[mu.x][mu.y].dipilih = true
                }
            }
        }
        
        func raja(i:Int, j:Int) -> Double{
            if bulet[i][j].rajas == true{
                return 1
            }
            else{
                return 0
            }
        }
        
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(MainScreen: .constant(true), sekarang: .constant(.pvp))
    }
}
