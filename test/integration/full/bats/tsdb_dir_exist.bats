#!/usr/bin/env bats

@test "hbase_rootdir exists" {
  test -d /var/spool/tsdhbase
}

@test "hbase install dir exists and is a link" {
  test -L /usr/local/hbase
}

@test "tsdb_cachedir exists" {
  test -d /var/cache/tsdb
}

@test "tsdb install dir exists" {
  test -d /usr/local/opentsdb
}

