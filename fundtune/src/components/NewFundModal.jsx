import React from 'react'

const NewFundModal = ({ open, setClose, children }) => {
    if (!open) return null;
   
    return (
    <div id="new-overlay">
        <div id="new-fund-modal">
            <div id="new-fund-title">Create New Fund</div>
            <div id="new-fund-msg">If you would like to create a new fund, please enter your desired artist and let the voting begin.</div>
            <div id="art-block">
                <span>Artist</span>
                <input placeholder='Artist..' />
            </div>
            {/* <div id="cit-block">
                <span>City</span>
                <input placeholder='City..' />
            </div> */}

            <div id="new-fund-btns">
                <div id="new-fund-create">Create</div>
                <div id="new-fund-close" onClick={setClose}>X</div>
            </div>

        </div>
    </div>
  )
}

export default NewFundModal