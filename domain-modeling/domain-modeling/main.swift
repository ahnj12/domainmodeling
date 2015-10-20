//
//  main.swift
//  domain-modeling
//
//  Created by Jooneil Ahn on 10/20/15.
//  Copyright © 2015 Jooneil Ahn. All rights reserved.
//

import Foundation

struct Money: Mathematics, CustomStringConvertible {
    var amount : Double
    var currency : String
    
    var description : String {
        get { return currency + String(amount) }
    }
    
    init(amount : Double, currency : String) {
        self.amount = amount
        if (currency == "USD" || currency == "GBP" ||
            currency == "EUR" || currency == "CAN") {
                self.currency = currency
        } else {
            print(currency + " is not a valid currency")
            exit(1)
        }
    }
    
    
    mutating func convert(conCurr : String) -> Void{
        switch currency {
        case("USD"):
            switch conCurr {
            case("EUR"):
                amount = amount * 1.5
            case("GBP"):
                amount = amount * 0.5
            case("CAN"):
                amount = amount * 1.25
            default:
                print("Invalid currency to convert to")
            }
        case("EUR"):
            switch conCurr {
            case("USD"):
                amount = amount / 1.5
            case("GBP"):
                amount = (amount / 1.5) / 2
            case("CAN"):
                amount = (amount / 1.5) * 1.25
            default:
                print("Invalid currency to convert to")
                
            }
        case("GBP"):
            switch conCurr {
            case("USD"):
                amount = amount * 2
            case("EUR"):
                amount = (amount * 2) * 1.5
            case("CAN"):
                amount = (amount * 2) * 1.25
            default:
                print("Invalid currency to convert to")
            }
        case("CAN"):
            switch conCurr {
            case("USD"):
                amount = amount / 1.25
            case("EUR"):
                amount = (amount / 1.25) * 1.5
            case("GBP"):
                amount = (amount / 1.25) * 0.5
            default:
                print("Invalid currency to convert to")
            }
        default:
            print("Invalid currency to convert to")
            
        }
    }
    
    
    
    mutating func add(addNum : Double, addCurr : String)->Void {
        if (currency == addCurr) {
            amount = amount + addNum
        } else {
            let original = currency
            convert(addCurr)
            amount = amount + addNum
            currency = addCurr
            convert(original)
            currency = original
        }
    }
    
    mutating func subtract (subNum : Double, subCurr : String) ->Void {
        if (currency == subCurr) {
            amount = amount - subNum
        } else {
            let original = currency
            convert(subCurr)
            amount = amount - subNum
            currency = subCurr
            convert(original)
            currency = original
        }
    }
}

class Job: CustomStringConvertible {
    var title : String
    var salary : Double
    
    var description : String {
        get { return title + " with a salary of $" + String(salary) }
    }
    
    init(title : String, salary : Double) {
        self.title = title
        self.salary = salary
    }
    
    func calculateIncome() -> Double {
        return salary
    }
    
    func raise(percent : Int) {
        salary = salary + (salary * (Double(percent) / 100))
    }
}

class Person: CustomStringConvertible {
    var firstName : String
    var lastName : String
    var age : Int
    var job : Job?
    var spouse : Person?
    
    var description : String {
        get { return self.toString() }
    }
    
    init(firstName : String, lastName : String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.job = nil
        self.spouse = nil
    }
    
    init(firstName : String, lastName : String, age : Int, job: Job) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        if (age >= 16) {
            self.job = job
        } else {
            self.job = nil
        }
        self.spouse = nil
    }
    
    init(firstName : String, lastName : String, age : Int, job : Job, spouse : Person) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        if (age >= 16) {
            self.job = job
        } else {
            self.job = nil
        }
        if (age >= 18) {
            self.spouse = spouse
        } else {
            self.spouse = nil
        }
    }
    
    func toString() -> String {
        let name = firstName + " " + lastName
        let stringAge = ", age " + String(age)
        if (age < 16) {
            return name + stringAge
        } else if (age < 18) {
            return name + stringAge + ", works as a " + job!.title
        } else {
            if (spouse != nil) {
                return name + stringAge + ", works as a " + job!.title + ", has a spouse named " + spouse!.firstName + " " + spouse!.lastName
            } else {
                return name + stringAge + ",works as a " + job!.title + ", has a spouse named "
            }
        }
    }
}

class Family: CustomStringConvertible {
    var members : [Person]
    
    var description : String {
        get {
            var famDescription : String = "The people in this family are: "
            for var i = 0; i < members.count - 1; ++i {
                famDescription = famDescription + members[i].firstName + " " + members[i].lastName + ", "
            }
            famDescription = famDescription + members[members.count - 1].firstName + " " + members[members.count - 1].lastName
            return famDescription
        }
    }
    
    init(members : [Person]) {
        var over21 : Bool = false
        for member in members {
            if (member.age > 21) {
                over21 = true
            }
        }
        if (!over21) {
            print("No member is over 21")
            exit(1)
        }
        self.members = members
    }
    
    func householdIncome() -> Double {
        var result : Double = 0
        for member in members {
            if (member.job != nil) {
                result = result + member.job!.salary
            }
        }
        return result
    }
    
    func haveChild(firstName : String, lastName : String) -> Void {
        members.append(Person(firstName: firstName, lastName: lastName, age: 0))
    }
}

// Tests
// Money-Tests
var money1 = Money(amount : 40.0, currency : "USD")
//var money5 = Money(amount: 0.0, currency: "TBS") // should print error
// Testing convert function
//money1.convert("GBP")
//print(money1.amount)
//money1.convert("EUR")
//print(money1.amount)
//money1.convert("CAN")
//print(money1.amount)
var money2 = Money(amount : 67.73, currency : "GBP")
//money2.convert("USD")
//print(money2.amount)
//money2.convert("EUR")
//print(money2.amount)
//money2.convert("CAN")
//print(money2.amount)
var money3 = Money(amount: 234.85, currency: "EUR")
//money3.convert("USD")
//print(money3.amount)
//money3.convert("GBP")
//print(money3.amount)
//money3.convert("CAN")
//print(money3.amount)
var money4 = Money(amount: 2.50, currency: "CAN")
//money4.convert("USD")
//print(money4.amount)
//money4.convert("GBP")
//print(money4.amount)
//money4.convert("EUR")
//print(money4.amount)










// Domain Modeling 2 Tests
print("---------- Domain Modeling 2 Tests -----------")
// Testing description property
print(money1.description)
print(money2.description)
print(money3.description)
print(money4.description)

// Testing adding/subtracting funcitons
// and description property
money1.add(5.0, addCurr: "USD")
print(money1.description)
money1.add(5.0, addCurr: "GBP")
print(money1.description)
money1.add(5.0, addCurr: "EUR")
print(money1.description)
money1.add(5.0, addCurr: "CAN")
print(money1.description)
money2.add(5.0, addCurr: "USD")
print(money2.description)
money2.add(5.0, addCurr: "GBP")
print(money2.description)
money2.add(5.0, addCurr: "EUR")
print(money2.description)
money2.add(5.0, addCurr: "CAN")
print(money2.description)
money3.add(5.0, addCurr: "USD")
print(money3.description)
money3.add(5.0, addCurr: "GBP")
print(money3.description)
money3.add(5.0, addCurr: "EUR")
print(money3.description)
money3.add(5.0, addCurr: "CAN")
print(money3.description)
money4.add(5.0, addCurr: "USD")
print(money4.description)
money4.add(5.0, addCurr: "GBP")
print(money4.description)
money4.add(5.0, addCurr: "EUR")
print(money4.description)
money4.add(5.0, addCurr: "CAN")
print(money4.description)
money1.subtract(5.0, subCurr: "USD")
print(money1.description)
money1.subtract(5.0, subCurr: "GBP")
print(money1.description)
money1.subtract(5.0, subCurr: "EUR")
print(money1.description)
money1.subtract(5.0, subCurr: "CAN")
print(money1.description)

// Testing Job class
var job1 = Job(title: "testjob", salary: 40000)
print(job1.description)
//print(job1.calculateIncome())
job1.raise(30) //raising by 30%
print(job1.description + "(after raise)")
//print(job1.salary)

// Testing Person class
var person1 = Person(firstName: "testf", lastName: "testl", age: 5)
print(person1.description)
//print(person1.toString())
var person2 = Person(firstName: "testf", lastName: "testl", age: 20, job: Job(title: "Cook", salary: 30000), spouse: Person(firstName: "spousef", lastName: "spousel", age: 19))
print(person2.description)
//print(person2.toString())
var person3 = Person(firstName: "under", lastName: "age", age: 8, job: job1)
print(person3.description)
//print(person3.toString())
var person4 = Person(firstName: "test4", lastName: "testl2", age: 40, job: job1)
print(person4.description)
//print(person4.toString())

// Testing Family class
var familyTest = Family(members: [person1, person2, person3, person4])
print(familyTest.description)
//print(familyTest.householdIncome())
familyTest.haveChild("babyf", lastName: "babyl")
print(familyTest.description)
//print(familyTest.members)
//var familyUnder = Family(members: [person1, person3]) // throws error


