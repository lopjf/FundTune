import { Link } from 'react-router-dom';
import logo from '../images/logo.png';
import { ConnectWallet, darkTheme } from '@thirdweb-dev/react';

const Nav = () => {
  return (
    <div id="nav">
     

      {/* <Link to="/">{"LOGO"}</Link> */}

      <div id="logo">
        <Link to="/">
        <img id="act-logo" src={logo} alt="logo"  />
        </Link>
      </div>

      <ul id="nav-items">
        <li><Link to="live">Live</Link></li>
        <li><Link to="aboutus">About us</Link></li>
        <li><Link to="faq">FAQ</Link></li>
        {/* <li id="wallet-btn">Connect Wallet</li> */}
        <div id="wallet-btn">
          <ConnectWallet
                  theme={darkTheme({
                    colors: {
                      accentText: "#7C65CD",
                      accentButtonBg: "#7C65CD",
                    },
                  })}
          />
        </div>
      </ul>

      

    </div>
  )
}

export default Nav