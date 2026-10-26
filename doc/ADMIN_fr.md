La console est derrière le SSO. Par défaut ce routeur est floodfill ; pour
rétrograder en simple relais : Config → Router manager.

## Tunnels clients (proxys eepsite)

Par conception, ce paquet fournit un jeu de clients limité au relais : la console du routeur, et rien d'autre — pas de proxy HTTP/SOCKS, pas d'eepsite, pas de SAM. Les tunnels clients s'ajoutent via le *Hidden Services Manager* de la console (I2P tunnels → Create) ; ils sont stockés dans `i2ptunnel.config.d/` dans le répertoire de données, donc conservés aux mises à jour et inclus dans les sauvegardes. Défauts amont si vous les recréez : proxy HTTP 4444, proxy HTTPS 4445, SAM 7656, eepsite 7658. Si l'app `i2pd` tourne sur le même serveur, éloignez ses proxys/SAM de ces numéros — ses questions d'installation servent précisément à cela.
