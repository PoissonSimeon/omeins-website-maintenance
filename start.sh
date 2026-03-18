#!/bin/bash
echo "=== SERVEUR MAINTENANCE OMEINS ==="

# 1. Vérification et installation de Node.js
if ! command -v node &> /dev/null; then
    echo "Installation de Node.js en cours..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt-get install -y nodejs
fi

# 2. Création automatique du micro-serveur web (Zero dépendance)
cat << 'EOF' > server.js
const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 8080;

const server = http.createServer((req, res) => {
    // Redirige toutes les requêtes vers index.html
    const filePath = path.join(__dirname, 'index.html');
    
    fs.readFile(filePath, (err, content) => {
        if (err) {
            res.writeHead(500);
            res.end('Erreur serveur interne');
        } else {
            res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
            res.end(content, 'utf-8');
        }
    });
});

server.listen(PORT, '0.0.0.0', () => {
    console.log(`\n🛡️  SERVEUR DE MAINTENANCE EN LIGNE SUR LE PORT ${PORT}`);
    console.log(`Toutes les requêtes renvoient vers la page de maintenance.`);
});
EOF

echo "========================================================"
echo "         DÉMARRAGE DU SERVEUR DE MAINTENANCE            "
echo "========================================================"
echo "Le serveur tourne en local sur le port 8080."
echo "Appuie sur Ctrl+C pour arrêter."
echo "========================================================"

# 3. Lancement du serveur
node server.js
