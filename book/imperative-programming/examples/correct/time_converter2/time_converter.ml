open Core

let () =
  printf "Pick a timezone: %!";
  match In_channel.input_line In_channel.stdin with
  | None -> failwith "No timezone provided"
  | Some zone_string ->
    let zone = Time_float_unix.Zone.find_exn zone_string in
    let time_string = Time_float.to_string_abs (Time_float.now ()) ~zone in
    printf "The time in %s is %s.\n%!" (Time_float_unix.Zone.to_string zone) time_string
