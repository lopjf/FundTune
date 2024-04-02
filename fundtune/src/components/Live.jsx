import React from 'react'
import Card from './Card';

const Live = () => {
  return (
    <div id="live">
      <div id="live-title">Live Funds</div>
      
      <div id="card-cont">
        <Card />
        <Card />  
        <Card />  
        <Card />  
        <Card />  

      </div>  

      <div id="new-fund">New Fund</div>
    </div>
  )
}

export default Live