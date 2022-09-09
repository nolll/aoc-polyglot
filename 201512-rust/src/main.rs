extern crate serde_json;

use std::fs;

fn main() {
    let input = read_input();
    //let input = "{ \"test\": 1, \"apa\": 2}".to_string();
    let json = parse_json(input);
    //println!("{}", json);
    
    let sum1 = get_recursive_sum(json);
    println!("{}", sum1);
    
    // let t = get_type(json);
    // println!("{}", t);
}

fn get_recursive_sum(data: serde_json::Value) -> i64 {
    match data{
        serde_json::Value::Number(d) => {
            let result = d.as_i64();
            match result{
                Some(i) => i,
                None => 0,
            }
        }
        serde_json::Value::String(_) => {
            return 0;
        }
        serde_json::Value::Object(d) => {
            let mut sum = 0;

            for (_key, value) in d{
                sum += get_recursive_sum(value);
            }
            return sum;
        }
        serde_json::Value::Array(d) => {
            let mut sum = 0;

            for i in 0..(d.len()) {
                sum += get_recursive_sum(d[i].clone());
            }
            return sum;
        }
        _ => {
            return 0;
        }
    }
}

fn parse_json(input: String) -> serde_json::Value {
    let json: serde_json::Value = serde_json::from_str(&input).expect("json error");
    return json;
}

fn read_input() -> String {
    let s = fs::read_to_string("input.txt").expect("file error");
    return s;
    // let mut file = File::open("input.txt").unwrap();
    // let mut stdout = stdout();
    // let str = &copy(&mut file, &mut stdout).unwrap().to_string();
    // return str.to_string();
}

// fn get_type(data: serde_json::Value) -> String {
//     match data{
//         serde_json::Value::Number(_) => {
//             return "Integer".to_string();
//         }
//         serde_json::Value::String(_) => {
//             return "String".to_string();
//         }
//         serde_json::Value::Object(_) => {
//             return "Object".to_string();
//         }
//         serde_json::Value::Array(_) => {
//             return "Array".to_string();
//         }
//         _ => {
//             return "Unknown".to_string();
//         }
//     }
// }
