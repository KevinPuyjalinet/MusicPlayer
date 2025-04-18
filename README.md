# 🎵 MusicPlayer

Une application iOS développée en **SwiftUI** et suivant le pattern **MVVM**, permettant de lire des morceaux de musique avec une interface moderne et animée.

---

## ✨ Fonctionnalités

- 🎧 Lecture de fichiers audio (.mp3)
- 🖼️ Affichage d’illustrations (artworks)
- ⏯️ Boutons de lecture, pause et navigation
- 🎚️ Sliders de volume et de timeline
- 🎛️ Interface découpée en composants modulaires
- 📳 **Retour haptique** à l'interaction pour une expérience utilisateur plus immersive

---

## 📦 Architecture

L'app suit l'architecture **MVVM** :

```
├── App/           → Point d’entrée de l’app (ContentView, App struct, etc.)
├── Model/         → Structures de données (ex : MusicData)
├── ViewModel/     → Logique de gestion des états (ex : AppleMusicViewModel)
├── View/          
│   ├── Screens/   → Les vues principales, découpées par section
│   └── Components/→ Composants réutilisables (ex : boutons, effets visuels)
├── Resources/     → Fichiers audio, assets visuels
├── Config/        → Entitlements, fichiers de configuration
```

---

## 📱 Technologies

- Swift 5
- SwiftUI 3+
- AVKit
- Haptics / UIKit feedback generator
- MVVM architecture

---

## 🚀 Lancer le projet

1. Clone le repo
2. Ouvre `MusicPlayer.xcodeproj` avec Xcode
3. Lance sur un simulateur ou appareil réel

---

## 🔮 Évolutions prévues

- Mode mini player
- Intégration de **MusicKit**
- Prise en charge d’une vraie playlist dynamique
- Intégration avec Apple Music API

---

## 👨‍💻 Auteur

Développé avec ❤️ par Kévin Puyjalinet – Développeur iOS

---
