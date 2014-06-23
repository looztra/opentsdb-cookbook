[![Build Status](https://travis-ci.org/looztra/opentsdb-cookbook.png?branch=master)](https://travis-ci.org/looztra/opentsdb-cookbook)

# opentsdb cookbook

Install and run [OpenTSDB](http://opentsdb.net/ "OpenTSDB") from source.

The typical use case is to be able to easily get the latest version.

The cookbook allow you to choose between the current stable (a.k.a 2.0, announced on 2014-05-05) and the bleeding edge, the [next branch](http://opentsdb.net/docs/build/html/).


# Requirements

Supports rehl and debian family for the moment (you can tweak the env var OPENTSDB_BASE_BOX to specify the basebox to be used by vagrant, defaulting to centos)

# Usage

- [Berkshelf](http://berkshelf.com/) is your friend
    - 'berks install' or
    - use the 'berkshelf vagrant plugin' and the recipes will be fetched during the vagrant provision step
- Since opentsdb 2.0 is officially the latest release available, this cookbook does not allow anymore to install opentsdb 1.1. You can choose between latest stable version by sticking to the master branch or to go for the bleeding edge version hosted in the 'next' branch. To choose between the two of them, just set the matching branch value for your node (node['opentsdb']['tsdb_branch'])
- A typical chef run would include **opentsdb::install** and **opentsdb::start** recipes that will install and start: *HBASE*, *Opentsdb* and *tcollector* and will start collecting some basic metrics (including opentsdb own metrics)
- This cookbook now propose recipes to install [Grafana](http://grafana.org/) through **install_grafana**. You can use **install_elasticsearch** if you don't already have one.

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
- node['opentsdb']['tools'] - some tools installed by default (default: ["nc","htop","sysstat"])
- node['elasticsearch']['cluster']['name'] - the ES cluster name that will be used (needed for **install_elasticsearch**, default: 'es_for_grafana')

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
- recipe **install_grafana**: Installs grafana
- recipe **install_elasticsearch**: Installs ES

# Todo

- provide service scripts for hbase, tcollector and opentsdb

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
