# 🚗 Parkeringsapp – Klient-Server-arkitektur med Databaslagring

En utökad parkeringsapplikation som använder en **Dart CLI-klient** och en **Shelf-server** med **CRUD-funktionalitet**.  

## 🏆 Mål
- 📡 **Klient**: En CLI-applikation som kommunicerar med servern via HTTP.
- 🖥 **Server**: En Shelf-baserad server som hanterar CRUD-operationer för:
  - 👤 Personer
  - 🚗 Fordon
  - 🅿️ Parkeringsplatser
  - 🏢 Parkeringar
- 📂 **Lagring**: Data sparas i minnet (kan utökas med JSON-fil eller databas).
- 🎯 **Funktioner**:
  - **Lägga till, visa och ta bort personer, fordon, parkeringar och parkeringsplatser.**
  - **REST API med GET, POST & DELETE.**
  - **Webbserver som svarar på HTTP-förfrågningar.**

---

## 📦 Installation

1. **Kloning av projektet**  
   ```sh
   git clone https://github.com/ditt-repo/assignment_1.git
   cd assignment_1
