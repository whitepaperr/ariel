import React, { useState } from 'react';

import { AboutNav, BreedNav } from './Navigation';
import PetList from './PetList';

function App(props) {
  const [pets, setPets] = useState(props.pets);

  const adoptPet = (name) => {
    let updatedPets = pets.map(pet => {return {...pet}});
    updatedPets.map(pet => {
      if(pet.name === name) {
        pet.adopted = true;
      }
    })
    setPets(updatedPets);
  }

  const breeds = [...new Set(props.pets.map(breedUnique => breedUnique.breed))]

  return (
    <div>
      <header className="jumbotron jumbotron-fluid py-4">
        <div className="container">
          <h1>Adopt a Pet</h1>
        </div>
      </header>

      <main className="container">
        <div className="row">
          <div id="navs" className='col-3'>
            <BreedNav breeds={breeds} />
            <AboutNav />
          </div>
          <div id='petList' className='col-9'>
            <PetList pets={pets} adoptCallback={adoptPet} />
          </div>
        </div>
      </main>

      <footer className="container">
        <small>Images from <a href="http://www.seattlehumane.org/adoption/dogs">Seattle Humane Society</a></small>
      </footer>

    </div>
  );
}


export default App;