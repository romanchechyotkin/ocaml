let rec factorial x: int = 
  match x<=1 with
  | true -> 1
  | false -> x * factorial(x-1)
let res = factorial 5;;
Printf.printf "%d\n" res

let res = factorial 6;;
Printf.printf "%d\n" res

let res = factorial 4;;
Printf.printf "%d\n" res

let res = factorial 1;;
Printf.printf "%d\n" res

let res = factorial 2;;
Printf.printf "%d\n" res

let res = factorial (-1);;
Printf.printf "%d\n" res


