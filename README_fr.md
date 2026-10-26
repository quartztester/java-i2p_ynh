<h1>
  <img src="logos/i2p.png" width="48" alt="I2P router logo">
  I2P pour YunoHost
</h1>

I2P est un réseau superposé anonyme et chiffré (« eepsites », tunnels, courrier I2P, partage de fichiers). Ce paquet exécute le routeur I2P officiel en natif (Java, sans Docker), avec sa console web derrière le portail YunoHost.

**Version livrée :** voir manifest.toml

## Caractéristiques

- Routeur I2P natif (Java) avec service systemd
- Console web du routeur (i2prouter console) via le portail YunoHost
- Tunnels et configuration persistants (data_dir)
- Mises à jour automatiques optionnelles du routeur (contrib)

Ce paquet fournit le **routeur Java amont** ([i2p.i2p](https://github.com/i2p/i2p.i2p)). Pour le routeur C++ léger, installez l'app séparée [`i2pd`](https://github.com/quartztester/i2pd_ynh) — les deux peuvent tourner côte à côte.

## Liens

- Projet amont : <https://geti2p.net>
- Paquet YunoHost : <https://github.com/quartztester/java-i2p_ynh>

## Screenshots

![I2P router — console stats](./doc/screenshots/console-stats.png)
![I2P router — console](./doc/screenshots/console.png)

