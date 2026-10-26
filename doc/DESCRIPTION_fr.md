I2P (Invisible Internet Project) est un réseau superposé mondial et décentralisé
pour la communication anonyme. Le trafic transite par des tunnels chiffrés via
d'autres routeurs bénévoles.

Ce paquet exécute un routeur I2P complet qui prête de la capacité au réseau :
il relaie le trafic des autres et s'enregistre par défaut comme « floodfill ».
La console est servie derrière le SSO.

Ce paquet fait tourner le routeur **Java** amont (i2p.i2p), distinct d'i2pd en C++ — une app YunoHost séparée empaquette ce routeur, et les deux peuvent cohabiter sur un même serveur.
