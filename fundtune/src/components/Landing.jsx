import React from 'react';
import bground from '../images/img.webp';

const Landing = () => {
  return (
    <div id="landing">
      <div id="container">
        <div id="text">
          <div id="title">Fund <br/> Tune</div>
          <div id="sub">The world’s first live music event crowdsourcing platform</div>
        </div>
        <div id="image">
          <div id="shader"></div>
          <div id="img-cont"><img id="act-img" src={bground} alt="background" /></div>
          
          <div id="shape"></div>
        </div>
      </div>
    </div>
  )
}

export default Landing