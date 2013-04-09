# murmur

Installs Murmur, the official [Mumble](http://mumble.sourceforge.net) server.

# Platforms

Tested on Ubuntu 12.04 and Debian 6.0.6.  
Will currently not work on non-Debian-likes because it uses an apt-specific installation flag, and relies on the [gem_installation cookbook](https://github.com/promisedlandt/cookbook-gem_installation), which only works on Debian and Ubuntu.

# Requirements

Chef 11

# Examples

```
# Let's overwrite the default password and welcome text
node.set[:murmur][:config][:variables] = {
  :serverpassword => {
    :value => "secretpassword"
  },
  :welcometext => {
    :value => '"Come mumble with us"'
  }
}

# Password for the SuperUser account
node.set[:murmur][:superuser_password] = "supersecretpassword"

# Finally, let's install
include_recipe "murmur"
```

# Recipes

## murmur::default

Installs Murmur.

# Attributes

## default

Attribute | Description | Type | Default
----------|-------------|------|--------
user      | system user to create | String | murmur
group     | system user group to create | String | murmur
init_style | How to start the murmur service. See below | String | runit
install_style | How to install murmur. See below | String | package
home_dir | Directory to install murmur to | String | /srv/murmur
config_dir | Directory where config will be saved | String | /etc/murmur
database_dir | Directory where the murmur sqlite file will be saved | String | /srv/murmur/database

## config

Attribute | Description | Type | Default
----------|-------------|------|--------
variables | Config variables hash. Detailed below | Hash | check attributes/default.rb

# init_style

## sysv

SysV style init script, included in the package installation.

## runit

Runit script, installed under /etc/sv/murmur/run

# install_style

## package

Install Murmur from package. Since the Mumble project does not have their own repository, these packages might be out of date.  
If this is a problem for you, let me know and I'll include installation from source.

# Resources / Providers

none

# Configuration variables hash structure

The configuration hash has an entry for every configuration setting in the following format:

```
:name_of_the setting => { :value   => "the value for this setting",
                          :comment => "optionally, comments for this setting" }

# actual example

# this...
:port => {
  :value   => "64738",
  :comment => "Port to bind TCP and UDP sockets to"
}

# ... will turn into this in the config file:
# Port to bind TCP und UDP sockets to
port=64738
```
