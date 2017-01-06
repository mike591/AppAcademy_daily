import React from 'react';

const ItemDetail = (props) => {
  return (
    <div>
      <p>{props.item.name}</p>
      <p>Happiness: {props.item.happiness}</p>
      <p>Price: ${props.item.price}</p>
    </div>
  );
};

export default ItemDetail;
