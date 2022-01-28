//
//  ContentView.swift
//  Shared
//
//  Created by anthony lim on 1/21/22.
//

import SwiftUI
import CorePlot

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
    @State var LocIndex = [Int]()
    @State var LocArray = [Double]()
    @State var MaxDArray = [Double]()
    @State var FinalParticleLocationArray = [Double]()
    @State var PartStep = 0.5
    @State var InitialInterationProbability = 1.0
    @State var TotalInteractionArray = [Int]()
    @State var TotalBackwardInteractionArray = [Int]()
    @State var TotalInteractionArrayCount = [Int]()
    @State var TotalInteractionArrayCountIndex = [Double]()
    @State var ParticleTrackingArray = [[Double]]()
    @State var CGPointXY : [(xPoint: Double, yPoint: Double)] = []
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
        TotalInteractionArrayCount = LocIndex
        TotalInteractionArrayCountIndex = LocArray
    }
    func ParticleFunction(){
        ParticleParameter()
        for i in 1 ... NPart{
            var PartLoc = PartLoc
            var PartAbs = AbsPro
            var ParticleMaxD = 0.0
            var IndexLoc = 0
            var interaction = 1
            var backwardscattering = 0
            var dScatDec = 0.0
            var PartTrackSingle = [Double]()
            var PartAbsDec = oneD.Absorption(AbsPro: AbsPro)
            PartTrackSingle.append(PartLoc)
            TotalInteractionArrayCount[Int(PartLoc/PartStep)] = TotalInteractionArrayCount[Int(PartLoc/PartStep)] + 1
            while PartAbsDec < 1
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
                PartTrackSingle.append(PartLoc)
                PartAbsDec = oneD.Absorption(AbsPro: AbsPro)
                if ParticleMaxD < PartLoc
                {
                    ParticleMaxD = PartLoc
                }
                TotalInteractionArrayCount[Int(PartLoc/PartStep)] = TotalInteractionArrayCount[Int(PartLoc/PartStep)] + 1
            }
            //ParticleTrackingArray.append(PartTrackSingle)
            //TotalInteractionArray.append(interaction)
            //TotalBackwardInteractionArray.append(backwardscattering)
            //FinalParticleLocationArray.append(PartLoc)
            //MaxDArray.append(ParticleMaxD)
        }
        /// MaxDArray Maximum distance traveled by a particle
        //print(MaxDArray)
        //print(MaxDArray.reduce(0,+)/Double(MaxDArray.count))
        //print(MaxDArray.count)
        
        //print(LocIndex)
        ///Location Array defines the depth of particle
        //print(LocArray)
        ///Final Particle Location for each particle
        //print(FinalParticleLocationArray)
        
        print(TotalInteractionArrayCount)
        print(TotalInteractionArrayCountIndex)
        //print(TotalBackwardInteractionArray.reduce(0,+))
        //print(TotalInteractionArray.reduce(0,+))
        

        
    }
    
    func SinglePart(){
        ParticleParameter()
        var CurrentLocation = 0.0
        CurrentLocation = CurrentLocation + PartStep
        var CurrentIndex = Int(CurrentLocation/PartStep)
        LocIndex[CurrentIndex] = LocIndex[CurrentIndex] + 1
        var interaction = Double.random(in: 0 ... 1)
        var AbsDecision = oneD.Absorption(AbsPro: interaction)
        
        
    }

    
    var body: some View
        {
            HStack{
                VStack{
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
                Text("Initial Particle Location")
                    .font(.callout)
                    .bold()
                TextField("Initial Particle Location", text: $PartLocString)
                    .padding()
                }
                .padding(.top, 5.0)
            /*
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
            */
             Button("Execution", action: {self.ParticleFunction()})
                .padding(.bottom, 5.0)
            
        }
        }
        }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
