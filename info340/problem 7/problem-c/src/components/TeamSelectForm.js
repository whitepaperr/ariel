import React, { useState } from 'react'; //import React Component

export default function TeamSelectForm(props) {

  const [selectInput, setSelectInput] = useState('');
  const [checkboxInput, setCheckboxInput] = useState(false);

  const handleSelect = (event) => {
    if(event.target.value!== selectInput){
      setSelectInput(event.target.value)
    }
  }
  const handleCheck = (event) => {
    if(event.target.checked !== checkboxInput){
      setCheckboxInput(event.target.checked);
    }
  }

  const btnOnClick = (event) => {
    props.applyFilterCallback(selectInput, checkboxInput)
  }

  const optionElems = props.teamOptions.map((teamName) => {
    return <option key={teamName} value={teamName}>{teamName}</option>
  })

  return (
    <div className="row align-items-center mb-3">
      <div className="col-auto">
        <select id="teamSelect" className="form-select" value={selectInput} onChange={handleSelect}>
          <option value="">Show all teams</option>
          {optionElems}
        </select>
      </div>
      <div className="col-auto">
        <div className="form-check">
          <input id="runnerupCheckbox" type="checkbox" className="form-check-input" checked={checkboxInput} onChange={handleCheck} />
          <label htmlFor="runnerupCheckbox" className="form-check-label">Include runner-up</label>
        </div>
      </div>
      <div className="col-auto">
        <button id="submitButton" type="submit" className="btn btn-warning" onClick={btnOnClick}>Apply Filter</button>
      </div>
    </div>
  );
}