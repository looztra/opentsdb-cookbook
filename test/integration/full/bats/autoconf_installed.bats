#!/usr/bin/env bats

@test "autoconf binary is found in PATH" {
  run which autoconf
  [ "$status" -eq 0 ]
}
