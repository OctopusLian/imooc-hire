
// exports.notEmpty = name => v =>
//     !v || v.trim() === '' ? `${name} is required` : true

export function isEmpty(str) {
    if (str === null || str === undefined || str === '') {
        return true;
    } else {
        return false;
    }
}

export function isNumber(number) {
    var regPos = /^\d+$/; // 非负整数
    if(regPos.test(number)){
        return true;
    }else{
        return false;
    }
}
