import { useState } from 'react'
import FundModal from './FundModal'

const Card = ({ data }) => {
  const [isOpen, setIsOpen] = useState();

  return (
    <div id="card">
        <div id="artist">{data.artist}</div>
        <div id="city">{data.city}</div>
        <div id="raised">$ {data.funds.toLocaleString()}</div>
        <div id="time">{data.expiration}</div>
        <div id="fund-btn" onClick={() => {setIsOpen(true)}}>Fund</div>
        <FundModal open={isOpen} setClose={() => setIsOpen(false)} data={data} />

    </div>
  )
}

export default Card