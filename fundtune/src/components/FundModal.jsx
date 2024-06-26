import React from 'react'

const FundModal = ({ open, setClose, data }) => {
    if (!open) return null;

  return (
    <div id="overlay">
        <div id="fund-modal">
            <div id="modal-title">{data.artist}</div>
            <div id="modal-msg">If you would like to fund this campaign for <b>{data.artist}</b> to play in <b>{data.city}</b>. You have to hold DAOToken to vote.</div>
            <div id="modal-btns">
                <div id="fund-modal-btn">Vote</div>
                <div onClick={setClose} id="close-fm">X</div>
            </div>

        </div>
    </div>
  )
}

export default FundModal