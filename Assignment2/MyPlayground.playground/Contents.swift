import UIKit

func practice(str : String, intVal : Int?) -> Int{
    print("String value is \(str)")
    
    guard let intVal = intVal else {
        print("Integer does not exist")
        return 0}
    print("Integer value is \(intVal)")
    return intVal * 5
}

print(practice(str: "pepper", intVal: 5))
print(practice(str: "pepper", intVal: nil))
