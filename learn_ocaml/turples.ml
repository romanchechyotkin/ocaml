let a_turple = (3, false, "adasd");;
let b_turple = (3, 5., false, "adasd");;

let (number, bool, string) = a_turple;;
Printf.printf "%d %b %s\n" number bool string;;

let distance (x1, y1) (x2, y2) = 
  Float.sqrt((x1-. x2) ** 2. +. (y1 -. y2) ** 2.);;

let res = distance(0., 0.) (1., 1.);;
Printf.printf "%f\n" res