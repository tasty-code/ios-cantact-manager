import Foundation

func validateSlashInput(input: String) -> Bool {
    if (input.filter{ $0 == "/" }.count != 2) {
        return false
    }
    return true
}

func checkNameError(name: String) -> Bool{
    if name.range(of: regex, options: .regularExpression) == nil {
        print("이름이 잘못되었습니다.")
        print(name)
        return false
    }else {
        return true
    }
}

func checkAgeError(age: String) -> Bool{
    if !age.allSatisfy({ $0.isNumber}){
        print("입력한 나이정보가 잘못되었습니다. 입력 형식을 확인해주세요.")
        return false
    } else if let changeToInt = Int(age) {
        if changeToInt >= 1000 {
            print("입력한 나이정보가 잘못되었습니다. 입력 형식을 확인해주세요.")
            print("숫자는 세자리수 이하로 입력해주세요.")
            return false
        }
    }
    return true
}

func calculateHyphenNum(input: String) -> Bool {
    if (input.filter { $0 == "-" }.count != 2) {
        return false
    }
    return true
}

func checkPhoneNumError(num: String) -> Bool {
    if !calculateHyphenNum(input: num){
        print("입력한 연락처정보가 잘못되었습니다. 입력 형식을 확인해주세요.")
        return false
    } else if num.components(separatedBy: ["-"]).joined().count < 9 {
        print("입력한 연락처정보가 잘못되었습니다. 입력 형식을 확인해주세요.")
        print("숫자는 9자리 이상이어야 합니다.")
        return false
    } else {
        return true
    }
}

func errorCheck(trimName: String, trimAge: String, trimNum: String) -> Bool {
    
    if (checkNameError(name: trimName) == false || checkAgeError(age: trimAge) == false || checkPhoneNumError(num: trimNum) == false) {
        return false
    } else {
        return true
    }
}

var isError: Bool = true
let regex = "^[A-Za-z\\s]+$"

while isError {
    print("")
    print("연락처 정보를 입력해주세요: ", terminator: "")
    
    if let input = readLine() {
        if !(validateSlashInput(input: input)) {
            print("입력된 정보가 [이름]/[나이]/[전화번호] 형식인지 확인해주세요")
            continue
        }
        
        let seperatedInput = input.components(separatedBy:"/")
        
        let trimName = seperatedInput[0].trimmingCharacters(in: [" "])
        let trimAge = seperatedInput[1].trimmingCharacters(in: [" "])
        let trimNum = seperatedInput[2].trimmingCharacters(in: [" "])
        
        let zeroBlankName = trimName.components(separatedBy: [" "]).joined()
        
        if errorCheck(trimName: trimName, trimAge: trimAge, trimNum: trimNum){
            isError = false
            print("입력한 정보는 \(trimAge)세 \(zeroBlankName)(\(trimNum))입니다.")
        } else{
            continue
        }
    }
}