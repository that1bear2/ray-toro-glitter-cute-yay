# rayglitteryay — Firebase Hosting deploy

This repository contains a single static page `rayglitteryay.html` (a mini social feed). The page can run entirely client-side (localStorage) or use Firebase Firestore to share posts across visitors.

This README shows how to deploy the page to Firebase Hosting and enable shared posts via Firestore.

Steps

1. Install the Firebase CLI (if you don't have it):

```bash
npm install -g firebase-tools
```

2. Create a Firebase project at https://console.firebase.google.com/. Enable **Firestore** in Native mode for shared posts.

3. Add a Web App in the Firebase Console and copy its config. In `rayglitteryay.html` replace the placeholder `FIREBASE_CONFIG` value (near the top of the file) with your config object. For example:

```js
const FIREBASE_CONFIG = {
  apiKey: "...",
  authDomain: "...",
  projectId: "your-project-id",
  storageBucket: "...",
  messagingSenderId: "...",
  appId: "..."
};
```

If you leave `FIREBASE_CONFIG = null`, the page will fall back to localStorage and posts will remain private to each visitor.

4. Prepare the `public/` folder for Firebase Hosting and copy the HTML there:

```bash
mkdir -p public
cp rayglitteryay.html public/index.html
```

5. (One-time) Initialize Firebase in this folder and choose Hosting (and Firestore if you want CLI-managed rules):

```bash
firebase login
firebase init
```

During `firebase init` select the Firebase project you created, choose `Hosting`, set `public` as the public directory, and configure as a single-page app (yes to rewrites) if prompted.

6. Deploy to Firebase Hosting:

```bash
./deploy.sh
```

Or run:

```bash
firebase deploy --only hosting
```

Notes and recommendations

- Images in posts are saved as data URLs in Firestore when remote sync is enabled. This is simple but not efficient for large images; consider using Firebase Storage for larger files.
- If you prefer automated setup, edit `.firebaserc` to add your `projectId` and use the provided `firebase.json`.
- The `deploy.sh` script is a convenience wrapper for `firebase deploy`.

If you'd like, I can also scaffold a small server-side API (Node/Express + SQLite) instead of Firebase — tell me which you prefer.
 
GitHub Pages quick deploy

If you want to publish the site on GitHub Pages so visitors can open it (and, if you enable Firestore, see shared posts):

1. Create a GitHub repository and push this folder.
2. The `docs/` folder contains a ready-to-publish copy of the site. On GitHub, go to Settings → Pages and select the `main` branch and `/docs` folder as the source.
3. Before publishing, open `docs/firebase-config.js` and paste your Firebase web app config (see earlier steps). If left blank, the site will run local-only.

Alternatively you can publish the `public/` folder to a `gh-pages` branch.

