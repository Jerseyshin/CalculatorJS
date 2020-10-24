//
//  CalculatorCore.swift
//  CalculatorJS
//
//  Created by apple on 2020/10/20.
//  Copyright © 2020 JersyShin. All rights reserved.
//

import Foundation

class CalculatorCore{
    var CurNum : Double
    var PreNum : Double
    var Opera : String
    
    var Point : Int
    var Minus : Bool
    
    
    var NumStr : String //Display
    
    var NumFlag : Int
    var constFlag : Bool
    var RefreshFlag : Bool
    var Radmode : Bool
    var BinFlag : Bool
    
    let e : Double
    let pi : Double
    
    
    init(){
        self.CurNum = 0
        self.PreNum = 0
        self.Opera = "Null"
        
        self.Point = 0
        self.Minus = false
        
        self.NumStr = "0"
        
        self.NumFlag = 0
        self.constFlag = false
        self.RefreshFlag = true
        
        self.e = 2.718281828459045
        self.pi = 3.141592653589793
        
        self.Radmode = false
        self.BinFlag = false
    }
    
    func angle2Rad(ang:Double)->Double{
        return ang / 180 * Double.pi
    }
    func rad2Ang(rad:Double)->Double{
        return rad / Double.pi * 180
    }
    
    func ClearAll(){
        self.CurNum = 0
        self.PreNum = 0
        self.Opera = "Null"
        
        self.Point = 0
        self.Minus = false
        
        self.NumStr = "0"
        
        self.NumFlag = 0
    }
    
    func ClearNum(){
        self.CurNum = 0
        self.Point = 0
        self.Minus = false
        self.NumStr = "0"
        self.constFlag = false
    }
    
    func DisplayNumStr(){
        if self.CurNum - round(self.CurNum) != 0{
            self.NumStr = String(self.CurNum)
        }else{
            self.NumStr = String(format: "%.0f", self.CurNum)
        }
    }
    
    func NumExtention(_ str: String) -> String{
        //flags:
        if self.NumFlag == 0{
            self.NumFlag = 1
        }else if self.NumFlag == 1 && self.BinFlag{
            self.NumFlag = 2
        }
        if self.RefreshFlag{
            self.RefreshFlag = false
            ClearNum()
        }
        
        if str == "." && !self.constFlag{
            if self.Point == 0{
                self.Point = 1
                self.NumStr += "."
            }
        }else if str == "+/-"{
            if Minus{
                self.NumStr = String(self.NumStr.dropFirst())
            }else{
                self.NumStr = "-" + self.NumStr
            }
            self.CurNum *= -1
            Minus = !Minus
        }else if str == "AC"{
            ClearAll()
        }else if str == "e"{
            self.constFlag = true
            ClearNum()
            self.CurNum = self.e
            DisplayNumStr()
        }else if str == "π"{
            self.constFlag = true
            ClearNum()
            self.CurNum = self.pi
            DisplayNumStr()
        }else if str == "Rand"{
            self.constFlag = true
            ClearNum()
            self.CurNum = Double(arc4random()) / Double(4294967295)
            DisplayNumStr()
        }
        else if !self.constFlag{
            if self.NumStr == "0"{
                self.NumStr = str
            }else{
                self.NumStr += str
            }
            self.CurNum = Double(self.NumStr)!
        }
        return self.NumStr
    }
    
    func IsUnaryOp(_ str: String) -> Bool{
        if str == "x^2" || str == "x^3" || str == "e^x" || str == "10^x" || str == "1/x" || str == "2√x" || str == "3√x" || str == "ln" || str == "log10" || str == "x!" || str == "sin" || str == "cos" || str == "tan" || str == "sinh" || str == "cosh" || str == "tanh" || str == "%"{
            return true
        }
        return false
    }
    
    func UnaryOpCal() -> String{
        if self.Opera == "x^2"{
            self.CurNum = pow(self.CurNum, 2)
        }else if self.Opera == "x^3"{
            self.CurNum = pow(self.CurNum, 3)
        }else if self.Opera == "e^x"{
            self.CurNum = pow(self.e, self.CurNum)
        }else if self.Opera == "10^x"{
            self.CurNum = pow(10, self.CurNum)
        }else if self.Opera == "1/x"{
            self.CurNum = pow(self.CurNum, -1)
        }else if self.Opera == "2√x"{
            self.CurNum = pow(self.CurNum, 1/2)
        }else if self.Opera == "3√x"{
            self.CurNum = pow(self.CurNum, 1/3)
        }else if self.Opera == "ln"{
            if self.CurNum <= 0{
                let res = "Error: ln<0"
                return res
            }else{
                self.CurNum = log(self.CurNum)
            }
        }else if self.Opera == "log10"{
            if self.CurNum <= 0{
                let res = "Error: log10<0"
                return res
            }else{
                self.CurNum = log10(self.CurNum)
            }
        }else if self.Opera == "x!"{
            if self.CurNum < 0{
                let res = "Error: x!<0"
                return res
            }else{
                var intite = 1
                var calnum = 1
                while Double(intite) < self.CurNum{
                    intite += 1
                    calnum *= intite
                }
                self.CurNum = Double(calnum)
            }
        }else if self.Opera == "sin"{
            var trinum = self.CurNum
            if !Radmode {
                trinum = angle2Rad(ang: self.CurNum)
            }
            let calnum = sin(trinum)
            self.CurNum = calnum
        }else if self.Opera == "cos"{
            var trinum = self.CurNum
            if !Radmode {
                trinum = angle2Rad(ang: self.CurNum)
            }
            let calnum = cos(trinum)
            self.CurNum = calnum
        }else if self.Opera == "tan"{
            var trinum = self.CurNum
            if !Radmode {
                trinum = angle2Rad(ang: self.CurNum)
            }
            let calnum = tan(trinum)
            self.CurNum = calnum
        }else if self.Opera == "sinh"{
            self.CurNum = sinh(self.CurNum)
        }else if self.Opera == "cosh"{
            self.CurNum = cosh(self.CurNum)
        }else if self.Opera == "tanh"{
            self.CurNum = tanh(self.CurNum)
        }else if self.Opera == "%"{
            self.CurNum = self.CurNum * 0.01
        }
        
        DisplayNumStr()
        self.Opera = "Null"
        self.RefreshFlag = true
        return self.NumStr
    }
    
    func IsBinOp(_ str: String) -> Bool{
        if str == "+" || str == "-" || str == "x" || str == "/" || str == "x^y" || str == "y√x"{
            return true
        }
        return false
    }
    
    func BinOpCal() -> String{
        if self.Opera == "+"{
            self.CurNum = self.PreNum + self.CurNum
        }else if self.Opera == "-"{
            self.CurNum = self.PreNum - self.CurNum
        }else if self.Opera == "x"{
            self.CurNum = self.PreNum * self.CurNum
        }else if self.Opera == "/"{
            if self.CurNum == 0{
                let res = "Error: /0"
                return res
            }
            self.CurNum = self.PreNum / self.CurNum
        }else if self.Opera == "x^y"{
            self.CurNum = pow(self.CurNum, self.PreNum)
        }else if self.Opera == "y√x"{
            if self.CurNum == 0{
                let res = "Error: /0"
                return res
            }
            self.CurNum = pow(self.CurNum, 1/self.PreNum)
        }
        DisplayNumStr()
        self.Opera = "Null"
        self.RefreshFlag = true
        self.BinFlag = false
        return self.NumStr
    }
    
    func OperatorDivider(_ str: String) -> String{
        var res : String = ""
        if self.NumFlag == 0{
            res = "Error : please input at least one number!"
        }else{
            if IsUnaryOp(str){
                let tmp = self.Opera
                self.Opera = str
                res = UnaryOpCal()
                if self.BinFlag{
                    self.Opera = tmp
                }
            }
            else if IsBinOp(str){
                if self.NumFlag == 1{
                    self.Opera = str
                    self.PreNum = self.CurNum
                    self.RefreshFlag = true
                    self.BinFlag = true
                    res = self.NumStr
                }else{
                    res = "Error : please press = first"
                }
            }else if str == "="{
                if self.BinFlag{
                    res = BinOpCal()
                    self.PreNum = self.CurNum
                    self.NumFlag = 1
                    self.BinFlag = false
                    self.RefreshFlag = true
                }else{
                    res = "Error : no need to ="
                }
            }
        }
        return res
    }
    
    
}
