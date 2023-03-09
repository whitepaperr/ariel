import React from 'react';

function PetCard(props) {
  let petCard = props.petCard;
  let petName = petCard.name;
  let petImg = petCard.img;
  let sexBreed = petCard.sex + " " + petCard.breed;

  const handleClick = () => {
      props.adoptCallback(petName)
  };

  if(petCard.adopted){
    petName = petName + " (Adopted)";
}

  return (
    <div className="card" onClick={handleClick}>
       <img className="card-img-top" src={ petImg } alt= { petName } />
        <div className="card-body">
            <h3 className="card-title">{ petName }</h3>
            <p className="card-text">{ sexBreed }</p>
        </div>
    </div>
  );
}

function PetList(props) {
  let petList = props.pets.map((pet) => {
    let element = <PetCard petCard={pet} adoptCallback={props.adoptCallback} />
    return element;
  })

  return(
    <div>
      <h2>Dogs for Adoption</h2>
      {petList};
    </div>
  );
}

export default PetList;