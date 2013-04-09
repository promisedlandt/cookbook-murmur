default[:murmur][:user] = "murmur"
default[:murmur][:group] = "murmur"

default[:murmur][:prereq_packages] = value_for_platform_family(
                                          "default" => []
                                        )

default[:murmur][:init_style] = "runit"
default[:murmur][:install_style] = "package"

default[:murmur][:home_dir] = "/srv/murmur"
default[:murmur][:database_dir] = ::File.join(node[:murmur][:home_dir], "database")
default[:murmur][:config_dir] = "/etc/murmur"

default[:murmur][:config][:variables] = { :database => {
                                            :value   => ::File.join(node[:murmur][:database_dir], "murmur.sqlite"),
                                            :comment => "Path to database. If blank, will search for
                                                         murmur.sqlite in default locations or create it if not found.
                                                         database=/var/lib/mumble-server/mumble-server.sqlite"
                                          },
                                          :welcometext => {
                                            :value   => "\"<br />Welcome to this server running <b>Murmur</b>.<br />Enjoy your stay!<br />\"",
                                            :comment => "The below will be used as defaults for new configured servers.
                                                         If you're just running one server (the default), it's easier to
                                                         configure it here than through D-Bus or Ice.

                                                         Welcome message sent to clients when they connect"
                                          },
                                          :port => {
                                            :value   => "64738",
                                            :comment => "Port to bind TCP and UDP sockets to"
                                          },
                                          :host => {
                                            :value   => nil,
                                            :comment => "Specific IP or hostname to bind to.
                                                         If this is left blank (default), murmur will bind to all available addresses."
                                          },
                                          :serverpassword => {
                                            :value   => "",
                                            :comment => "Password to join server "
                                          },
                                          :bandwidth => {
                                            :value   => "720000",
                                            :comment => "Maximum bandwidth (in bits per second) clients are allowed
                                                         to send speech at."
                                          },
                                          :users => {
                                            :value   => "20",
                                            :comment => "Maximum number of concurrent clients allowed."
                                          },
                                          :uname => {
                                            :value   => node[:murmur][:user],
                                            :comment => "If murmur is started as root, which user should it switch to?
                                                         This option is ignored if murmur isn't started with root privileges."
                                          }
                                        }
