//: Factory Method Pattern: Employee example.
//:
//: Reference: https://refactoring.guru/design-patterns/factory-comparison
protocol EmployeeType { var id: Int { get } }
struct Programmer: EmployeeType { let id: Int }
struct Accountant: EmployeeType { let id: Int }

// Factory
protocol DepartmentType {
    func createEmployee(id: Int) -> EmployeeType
}

struct ITDepartment: DepartmentType {
    func createEmployee(id: Int) -> EmployeeType {
        // ... some logic for registering a new programmer
        Programmer(id: id)
    }
}
struct AccountingDepartment: DepartmentType {
    func createEmployee(id: Int) -> EmployeeType {
        // ... some logic for registering a new accountant
        Accountant(id: id)
    }
}


// MARK: - Main
var employee: EmployeeType

employee = ITDepartment().createEmployee(id: 1)
employee = AccountingDepartment().createEmployee(id: 2)
