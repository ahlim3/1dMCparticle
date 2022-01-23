//
//  ContentView.swift
//  Shared
//
//  Created by anthony lim on 1/21/22.
//

import SwiftUI

struct ContentView: View
    {
    /// initiating the Scattering Tools
    @ObservedObject var oneD = OneDScattering()

    ///Initializing the variables required for the calcualtion
    @State var NPart = 10
    @State var PartLoc = 0.0
    @State var AbsPro = 0.5
    @State var FwSctPro = 0.5
    @State var MediumLength = 10.0
    @State var LocIndex = [Double]()
    @State var LocArray = [Double]()
    @State var MaxDArray = [Double]()
    @State var FinalParticleLocationArray = [Double]()
    @State var PartStep = 0.5
    @State var TotalInteractionArray = [Int]()
    @State var TotalBackwardInteractionArray = [Int]()
    @State var PartStepString = "0.5"
    @State var PartLocString = "0.0"
    @State var NPartString = "10"
    @State var AbsProString = "0.5"
    @State var FwSctProString = "0.5"
    @State var MediumLengthString = "10.0"
    @State var TotalBackwardinteractionString = ""
    @State var TotalinteractionString = ""
    
    func ParticleParameter(){
        AbsPro = Double(AbsProString)!
        FwSctPro = Double(FwSctProString)!
        PartStep = Double(PartStepString)!
        MediumLength = Double(MediumLengthString)!
        PartLoc = Double(PartLocString)!
        NPart = Int(NPartString)!
        LocIndex = oneD.LocationIndex(Max: MediumLength, Step: PartStep)
        LocArray = oneD.LocationArray(Max: MediumLength, Step: PartStep)
    }
    func ParticleFunction(){
        ParticleParameter()
        for _ in 1 ... NPart{
            var PartLoc = 0.0
            var PartAbs = 0
            var ParticleMaxD = 0.0
            var IndexLoc = 0
            var interaction = 1
            var backwardscattering = 0
            var dScatDec = 0.0
            PartAbs = oneD.Absorption(AbsPro: AbsPro)
            while PartAbs < 1
            {
                IndexLoc = Int(PartLoc / PartStep)
                LocIndex[IndexLoc] = LocIndex[IndexLoc] + 1
                dScatDec = oneD.ScatDec(PartStep: PartStep, ForwardScatteringProbability: FwSctPro)
                if dScatDec < 0 {
                    backwardscattering = backwardscattering + 1
                }
                PartLoc = PartLoc + dScatDec
                interaction = interaction + 1
                if PartLoc < 0.0 {
                    break
                }
                else if PartLoc > 10.0 {
                    break
                }
                PartAbs = oneD.Absorption(AbsPro: AbsPro)
                if ParticleMaxD < PartLoc
                {
                    ParticleMaxD = PartLoc
                }

            }
            TotalInteractionArray.append(interaction)
            TotalBackwardInteractionArray.append(backwardscattering)
            FinalParticleLocationArray.append(PartLoc)
            MaxDArray.append(ParticleMaxD)
        }
        //print(MaxDArray)
        print(MaxDArray.reduce(0,+)/Double(MaxDArray.count))
        print(MaxDArray.count)
        print(LocIndex)
        print(LocArray)
        print(FinalParticleLocationArray)
        print(TotalBackwardInteractionArray.reduce(0,+))
        print(TotalInteractionArray.reduce(0,+))
        

        
    }

    
    var body: some View
        {
        VStack(alignment: .center)
            {
            Text("Number of Particle")
                .font(.callout)
                .bold()
            TextField("# of Particle", text: $NPartString)
                .padding()
            }
            .padding(.top, 5.0)
            VStack(alignment: .center)
                {
                Text("Particle Absorption Probability")
                    .font(.callout)
                    .bold()
                TextField("We can not determined until observation has made", text: $AbsProString)
                    .padding()
                }
                .padding(.top, 5.0)
            VStack(alignment: .center)
                {
                Text("Particle Forward Scattering Probability")
                    .font(.callout)
                    .bold()
                TextField("We can not determined until observation has made", text: $FwSctProString)
                    .padding()
                }
                .padding(.top, 5.0)
            VStack(alignment: .center)
                {
                Text("Length of the Medium")
                    .font(.callout)
                    .bold()
                TextField("cm", text: $MediumLengthString)
                    .padding()
                }
                .padding(.top, 5.0)
            VStack(alignment: .center)
                {
                Text("Distance Traveled per interaction")
                    .font(.callout)
                    .bold()
                TextField("cm", text: $PartStepString)
                    .padding()
                }
                .padding(.top, 5.0)
            VStack(alignment: .center)
                {
                Text("Particle Termination Location")
                    .font(.callout)
                    .bold()
                TextField("Particle Termination Location", text: $PartLocString)
                    .padding()
                }
                .padding(.top, 5.0)
            VStack(alignment: .center)
                {
                Text("Total number of scattering event")
                    .font(.callout)
                    .bold()
                TextField("Particle Termination Location", text: $TotalinteractionString)
                    .padding()
                }
                .padding(.top, 5.0)
            VStack(alignment: .center)
                {
                Text("Total number of back scattering event")
                    .font(.callout)
                    .bold()
                TextField("Particle Termination Location", text: $TotalBackwardinteractionString)
                    .padding()
                }
                .padding(.top, 5.0)
            Button("Execution", action: {self.ParticleFunction()})
                .padding(.bottom, 5.0)
            
        }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
