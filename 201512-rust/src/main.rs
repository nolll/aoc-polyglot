extern crate serde_json;

use std::fs;

fn main() {
    let input = read_input();
    let json = parse_json(input);
    
    let sum1 = get_recursive_sum(json.clone(), true);
    println!("{}", sum1);

    let sum2 = get_recursive_sum(json.clone(), false);
    println!("{}", sum2);
}

fn get_recursive_sum(data: serde_json::Value, include_red: bool) -> i64 {
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
            let mut has_red = false;

            for (_key, value) in d{
                if value == "red" {
                    has_red = true;
                }
                sum += get_recursive_sum(value, include_red);
            }

            if !include_red && has_red {
                return 0;
            }

            return sum;
        }
        serde_json::Value::Array(d) => {
            let mut sum = 0;

            for i in 0..(d.len()) {
                sum += get_recursive_sum(d[i].clone(), include_red);
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
}
