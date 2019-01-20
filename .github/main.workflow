workflow "Build and Test" {
  on = "push"
  resolves = ["build"]
}

action "opam install" {
  uses = "avsm/actions-ocaml/opam@master"
}

action "build" {
  needs = ["opam install"]
  uses = "avsm/actions-ocaml/dune@master"
  args = "build"
}

