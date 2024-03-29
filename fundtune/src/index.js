import React from 'react';
import ReactDOM from 'react-dom/client';
import './scss/main.scss';
import App from './App';
import {
  ThirdwebProvider,
  metamaskWallet,
  coinbaseWallet,
  walletConnect,
} from '@thirdweb-dev/react';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <ThirdwebProvider
    supportedWallets={[metamaskWallet(), coinbaseWallet(), walletConnect()]}
    activeChain="sepolia"
    clientId="abc35d19f018e382a1c2f9445dc73b6a"
  >
    <App />
  </ThirdwebProvider>
);
