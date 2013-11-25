[![Build Status](https://travis-ci.org/looztra/opentsdb-cookbook.png?branch=master)](https://travis-ci.org/looztra/opentsdb-cookbook)

# opentsdb cookbook

Install and run [OpenTSDB](http://opentsdb.net/ "OpenTSDB") from source.

The typical use case is to be able to easily get the latest version.

The cookbook allow you to choose between the current stable (a.k.a 1.1) and the soon to be released as a RC, the [v2.0 / next branch](http://opentsdb.net/docs/build/html/).


# Requirements

Only supports rehl family for the moment. Running on ubuntu should only need some tweaks (feel free to send a Pull Request!)

# Usage

- [Berkshelf](http://berkshelf.com/) is your friend
    - 'berks install' or
    - use the 'berkshelf vagrant plugin' and the recipes will be fetched during the vagrant provision step
- This cookbook can install and run opentsdb 1.1 or next/2.0. To choose between the two of them, just set the matching branch value for your node (node['opentsdb']['tsdb_branch'])
- A typical chef run would include **opentsdb::install** and **opentsdb::start** recipes that will install and start: *HBASE*, *Opentsdb* and *tcollector* and will start collecting some basic metrics (including opentsdb own metrics)

# Attributes

- node['opentsdb']['ifcfg'] - the network interface the hbase server will be bound to (default: 'lo')
- node['opentsdb']['user'] - the user for hbase (default: 'root')
- node['opentsdb']['hbase_rootdir'] - the hbase root dir (default: '/var/spool/tsdhbase')
- node['opentsdb']['hbase_installdir'] - the base directory where the hbase install dir will be put (default: '/usr/local')
- node['opentsdb']['hbase_version'] - the version of hbase to install (default: '0.94.8')
- node['opentsdb']['tsdb_installdir'] - the base directory where the opentsdb install dir will be put (default: '/usr/local')
- node['opentsdb']['tsdb_cachedir'] - the tsdb cache directory (default: '/var/cache/tsdb')
- node['opentsdb']['tsdb_repo'] - the git directory to use (default: 'git://github.com/OpenTSDB/opentsdb.git')
- node['opentsdb']['tsdb_branch'] - the git branch to use (default: 'master'. Other possibility is next to build a v2 for instance)
- node['opentsdb']['build_from_src'] - build opentsdb from source (default: 'true')
- node['opentsdb']['tsdb_port'] - port for the tsdb process (default: '4242')
- node['opentsdb']['tsdb_autometrics'] - create new metrics automatically (default: 'true')
- node['opentsdb']['tcollector_repo'] - the git directory to use for tcollector (default: 'https://github.com/OpenTSDB/tcollector.git')
- node['opentsdb']['tcollector_installdir'] - the base directory where the tcollector install dir will be put (default: '/usr/local')
- node['opentsdb']['proxy']['enabled'] - use a proxy (default: 'true')
- node['opentsdb']['proxy']['http_proxy'] - http_proxy (default: 'nil')
- node['opentsdb']['proxy']['https_proxy'] - https_proxy (default: 'nil')
- node['opentsdb']['tools'] - some tools installed by default (default: ["nc","htop","sysstat"])

# Recipes

- recipe **default**: see install recipe
- recipe **prepare**: Install and setup requirements (ntp, package manager, java)
- recipe **install**: Install HBase, OpenTSDB and tcollector from source (install_hbase+install_opentsdb+install_tcollector)
- recipe **start**: Start hbase, tsd and tcollector daemons (start_hbase+start_opentsdb+start_tcollector)
- recipe **install_hbase**: Install HBase
- recipe **install_opentsdb**: Install Opentsdb
- recipe **install_tcollector**: Install tcollector
- recipe **start_hbase**: Start HBase
- recipe **start_opentsdb**: Start Opentsdb
- recipe **start_tcollector**: Start tcollector

# Todo

- provide service scripts for hbase, tcollector and opentsdb
- cleanup the proxy handling that should no be there I think

# License and Author

Author:: Christophe Furmaniak

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
