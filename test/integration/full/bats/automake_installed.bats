#!/usr/bin/env bats

@test "automake binary is found in PATH" {
  run which automake
  [ "$status" -eq 0 ]
}
