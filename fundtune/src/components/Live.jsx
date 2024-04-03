import { useState } from 'react'
import Card from './Card';
import NewFundModal from './NewFundModal';
import { data } from './dummyData';

const dataMap = data.map((fund, i) => {
  return (
    <Card data={data[i]} />
  )
})

const Live = () => {
  const [newIsOpen, setNewIsOpen] = useState();

  return (
    <div id="live">
      <div id="live-title">Live Funds</div>
      
      <div id="card-cont">
        {dataMap} 

      </div>  

      <div id="new-fund" onClick={() => {setNewIsOpen(true)}}>New Fund</div>
      <NewFundModal open={newIsOpen} setClose={() => {setNewIsOpen(false)}} />
    </div>
  )
}

export default Live