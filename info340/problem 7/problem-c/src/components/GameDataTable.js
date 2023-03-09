import React, { useState } from 'react'; //import React Component

import _ from 'lodash'; //import external library!

export default function GameDataTable(props) {

  const [sortByCriteria, setSortByCriteria] = useState(null);
  const [isAscending, setIsAscending] = useState(null);

  const handleClick = (event) => {
    setSortByCriteria(event.currentTarget.name);
    if(event.currentTarget.name === sortByCriteria) {
      if(isAscending===true) {
        setIsAscending(false);
      }else {
        setIsAscending(null);
        setSortByCriteria(null);
      }
    }else {
      setIsAscending(true);
    }
  }

  let rowInfo = _.sortBy(props.data, sortByCriteria);
  if (sortByCriteria !== null && isAscending === false) {
    rowInfo = _.reverse(rowInfo);
  }

  let activeYear = false;
  if(sortByCriteria === 'year') {
    activeYear = true;
  } else {
    activeYear = false;
  }

  let ascendYear = true;
  if (sortByCriteria === 'year' && isAscending === true) {
    ascendYear = true;
  } else {
    ascendYear = false;
  }

  let activeWinner = false;
  if(sortByCriteria === 'winner') {
    activeWinner = true;
  } else {
    activeWinner = false;
  }

  let ascendWinner = true;
  if (sortByCriteria === 'winner' && isAscending === true) {
    ascendWinner = true;
  } else {
    ascendWinner = false;
  }

  let activeScore = false;
  if(sortByCriteria === 'score') {
    activeScore = true;
  } else {
    activeScore = false;
  }

  let ascendScore = true;
  if (sortByCriteria === 'score' && isAscending === true) {
    ascendScore = true;
  } else {
    ascendScore = false;
  }

  let activeRunner = false;
  if(sortByCriteria === 'runner_up') {
    activeRunner = true;
  } else {
    activeRunner = false;
  }
  
  let ascendRunner = true;
  if (sortByCriteria === 'runner_up' && isAscending === true) {
    ascendRunner = true;
  } else {
    ascendRunner = false;
  }



  //convert data into rows
  const rows = rowInfo.map((match) => {
    return <GameDataRow key={match.year} game={match} />
  });

  return (
    <div className="table-responsive">
      <table className="table">
        <thead>
          <tr>
            <th>
              Year
              <SortButton name="year" onClick={handleClick} active={activeYear} ascending={ascendYear} />
            </th>
            <th className="text-end">
              Winner
              <SortButton name="winner" onClick={handleClick} active={activeWinner} ascending={ascendWinner} />
            </th>
            <th className="text-center">
              Score
              <SortButton name="score" onClick={handleClick} active={activeScore} ascending={ascendScore} />
            </th>
            <th>
              Runner-Up
              <SortButton name="runner_up" onClick={handleClick} active={activeRunner} ascending={ascendRunner} />
            </th>
          </tr>
        </thead>
        <tbody>
          {rows}
        </tbody>
      </table>
    </div>
  );
}

//Component for managing display logic of sort button
//Props: 
//  `active` [boolean] if icon should be highlighted,
//  `ascending` [boolean] if icon should be in ascending order (flipped)
//  `onClick` [function] click handler (passthrough)
function SortButton(props) {
  let iconClasses = ""
  if (props.active) { iconClasses += ` active` }
  if (props.ascending) { iconClasses += ` flip` };

  return (
    <button className="btn btn-sm btn-sort" name={props.name} onClick={props.onClick}>
      <span className={"material-icons" + iconClasses} aria-label={`sort by ${props.name}`}>sort</span>
    </button>
  );
}

function GameDataRow({ game }) { //game = props.game
  return (
    <tr>
      <td>{game.year}</td>
      <td className="text-end">{game.winner} {game.winner_flag}</td>
      <td className="text-center">{game.score}</td>
      <td>{game.runner_up_flag}&nbsp;&nbsp;{game.runner_up}</td>
    </tr>
  );
}
