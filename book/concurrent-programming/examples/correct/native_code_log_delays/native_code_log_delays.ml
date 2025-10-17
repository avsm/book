open Core
open Async

let log_delays thunk =
  let start = Time_float.now () in
  let print_time () =
    let diff = Time_float.diff (Time_float.now ()) start in
    printf "%s, " (Time_float.Span.to_string diff)
  in
  let d = thunk () in
  Clock.every (sec 0.1) ~stop:d print_time;
  let%bind () = d in
  printf "\nFinished at: ";
  print_time ();
  printf "\n";
  Writer.flushed (force Writer.stdout)

let noalloc_busy_loop () =
  for _i = 0 to 5_000_000_000 do
    ()
  done

let () =
  don't_wait_for
    (let%map () =
       log_delays (fun () -> In_thread.run noalloc_busy_loop)
     in
     shutdown 0);
  never_returns (Scheduler.go ())
