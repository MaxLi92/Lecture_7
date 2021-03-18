import UIKit
import Foundation

enum carError: Error {
    case noCar
    case noGasoline(gasolineNeed: Int)
    case noFreeCar
}

struct Car {
    var bootGasoline: Int
    var car: Int
}

class rentalCar {
    
    var invent = [
        "BMW": Car(bootGasoline: 50, car: 3),
        "Toyota": Car(bootGasoline: 90, car: 1),
        "AUDI": Car(bootGasoline: 45, car: 5),
        "Porshe": Car(bootGasoline: 60, car: 1)
    ]
    
    var gasoline = 0
    
    func errors(carMark name: String) throws{
        
        guard let cars = invent[name] else {
            throw carError.noCar
        }
        
        guard cars.car > 0 else {
            throw carError.noFreeCar
        }
        
        guard (cars.bootGasoline - (cars.bootGasoline - gasoline) ) != 0 else {
            throw carError.noGasoline(gasolineNeed: cars.bootGasoline-gasoline)
        }
        
        var someCar = cars
        someCar.car -= 1
        invent[name] = someCar
        
        print("\(name) уехала")
    }
}

let nameDriver = [
    "Slava": "BMW",
    "Nick": "Toyota",
    "Petr": "AUDI"
]

func voteDriver(driver: String, Cars: rentalCar) throws {
    
    let driverName = nameDriver[driver] ?? "Porshe"
    try Cars.errors(carMark: driverName)
    
}
var driver = rentalCar()
driver.gasoline = 0

do {
    try voteDriver(driver: "Slava", Cars: driver)
} catch carError.noCar{
    print("Нет такой машины")
} catch carError.noGasoline(let gasolineNeed){
    print("Пустой бензобак, залейте \(gasolineNeed) литров")
} catch carError.noFreeCar{
    print("Нет свободной машины")
}
