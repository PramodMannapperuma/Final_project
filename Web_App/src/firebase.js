import { initializeApp } from 'firebase/app';
import { getFirestore } from 'firebase/firestore';

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyAv3EX68kMdoBImg_ajL499sSyRF_8Jnic",
  authDomain: "revmaster-3e9df.firebaseapp.com",
  projectId: "revmaster-3e9df",
  storageBucket: "revmaster-3e9df.appspot.com",
  messagingSenderId: "1029614245585",
  appId: "1:1029614245585:web:5165d1f8ca266dbeff97f0",
  measurementId: "G-3GJ4JKZQCF"
};

// Initialize Firebase
const firebaseApp = initializeApp(firebaseConfig);
const firestore = getFirestore(firebaseApp);
export { firestore };
// const app = initializeApp(firebaseConfig);
// const firestore = getFirestore(app);
// export { firestore };
// const auth = getAuth(app);
// export { app, auth} ;