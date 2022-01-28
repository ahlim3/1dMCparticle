
//  1DScattering.swift
//  1DMCScattering
//
//  Created by anthony lim on 1/22/22.
//

import Foundation
class OneDScattering: ObservableObject{

    var AbsPro = 0.5
    var FwSctPro = 0.5
    var MediumLength = 10.0
    var LocIndex = [Double]()
    var LocArray = [Double]()
    var PartStep = 0.5
    var PartLoc = 0.0
    
    ///Function for generating location index
    func LocationIndex(Max: Double, Step: Double) -> [Int]
    {
        let Max = Max
        let Step = Step
        let LocIndex = Int(Max/Step)
        let LocationIndex = [Int](repeating: 0, count: LocIndex)
        return LocationIndex
    }
    
    ///Function for location array
    func LocationArray (Max: Double, Step: Double) -> [Double]
    {
        let Max = Max
        let Step = Step
        let LocIndex = Int(Max/Step)
        var currentLoc = 0.0
        var LocationArray:[Double] = []
        for i in 0 ..< LocIndex
        {
            LocationArray.append(currentLoc)
            currentLoc = currentLoc + Step
        }
        LocationArray.append(currentLoc)
        return LocationArray
    }
    
    ///Function particle location termination determined by location
    func PartLocIn(Minimum : Double, Maximum: Double, Location: Double) -> Int
    {
        // 0 within the range for particle inside the slap, 1 for outside the slap
        var PartDecision = 0
        if Location > Maximum{
            PartDecision = 1
        }
        else if Location < Minimum{
            PartDecision = 1
        }
        else
        {
            PartDecision = 0
        }
        return PartDecision
    }
    
    ///Function for absorption decision
    func Absorption(AbsPro:Double) -> Int
    {
        let Part = Double.random(in: 0.0 ... 1.0)
        let AbsPro = AbsPro
        var AbsDec = 0
        if Part < AbsPro{
            AbsDec = 1
        }
        return AbsDec
    }
    
    ///Function for scattering direction decision
    func ScatDec(PartStep: Double, ForwardScatteringProbability: Double) -> Double
    {
        let Part = Double.random(in: 0.0 ... 1.0)
        let ForwardScatteringProbability = ForwardScatteringProbability
        var PartStep = PartStep
        if Part < ForwardScatteringProbability{
            PartStep = -1.0 * PartStep
        }
        return PartStep
    }
    
    /// Function for particle Location
    func FPartLoc(PartLoc: Double, ParticleTravelPerStep: Double, FowardScatteringProbability: Double) -> Double{
        let PartStep = ParticleTravelPerStep
        let FwSctPro = FowardScatteringProbability
        var PartLoc = PartLoc + ScatDec(PartStep: PartStep, ForwardScatteringProbability: FwSctPro)
        return PartLoc
    }
}
