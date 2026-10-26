I2P (Invisible Internet Project) is a global, decentralized overlay network for anonymous communication. Traffic is relayed through encrypted, single-hop tunnels that pass through other volunteers' routers before reaching its destination, making it hard to observe who is talking to whom.

This package runs a full I2P router that volunteers capacity to the network: it forwards other users' traffic and, by default, registers as a "floodfill" — one of the routers that answer distributed-routing-database queries for the whole network. (To run as a plain relay instead, turn it off in the console: Config → Router manager.) The router console (statistics, peer and tunnel info, log level) is served on its own domain behind YunoHost's SSO — anonymous visitors cannot reach it.

Nothing is proxied for website visitors; the router only shuttles encrypted I2P traffic, the same as every other I2P node on the network. A floodfill answers many small requests per second, so expect a modest but steady share of your bandwidth (a few hundred kB/s typically) and a somewhat higher router uptime expectation from the network. See the README for ISP/terms-of-service considerations before volunteering bandwidth.

This package runs the upstream **Java** router (i2p.i2p), distinct from the C++ i2pd — a separate YunoHost app packages that router, and both can run side by side on one server.
