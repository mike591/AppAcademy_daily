Array.prototype.uniq = function() {
  let emptyArray = [];
  this.forEach((el) => {
    if (!emptyArray.includes(el)) { emptyArray.push(el); }
  });
  return emptyArray;
};

let r = [1,1,2,3,3,4];

// console.log(r.uniq()); // [1,2,3,4]

Array.prototype.twoSum = function () {
  let coordinates = [];
  for (let i = 0; i < this.length-1; i++) {
    for (let j = i+1; j < this.length; j++) {
      if (this[i] + this[j] === 0) { coordinates.push([i, j]); }
    }
  }
  return coordinates;
};

r = [-1, 0, 2, -2, 1];

// console.log(r.twoSum()); // [[0,4], [2,3]]

Array.prototype.transpose = function() {
  let result = [];
  for (let i = 0; i < this.length; i++) {
    let temp = [];
    for (let j = 0; j < this.length; j++) {
      temp.push(this[j][i]);
    }
    result.push(temp);
  }
  return result;
};

r = [[0,1,2],[3,4,5],[6,7,8]];

// console.log(r.transpose());

Array.prototype.myEach = function(func) {
  for (let i =0; i < this.length; i++) {
    func(this[i]);
  }
};

r = [1,2,3,4];

// r.myEach(function(el) { console.log(el); });

Array.prototype.myMap = function(func) {
  let result = [];
  this.myEach(function(el) {
    result.push(func(el));
  });
  return result;
};

// console.log(r.myMap(function(el) { return el * 2; }));

Array.prototype.myInject = function(func) {
  let accum = this[0];
  this.slice(1, this.length).myEach(function(el) {
    accum = func(el, accum);
  });
  return accum;
};

// console.log(r.myInject(function(el, accum) { return el * accum; } ));

function bubbleSort(array) {
  let sorted = false;
  while (!sorted) {
    sorted = true;
    for (let i = 0; i < array.length; i++) {
      if (array[i] > array[i+1]) {
        let temp = array[i+1];
        array[i+1] = array[i];
        array[i] = temp;
        sorted = false;
      }
    }
  }
  return array;
}

r = [5,4,3,2,1];
// console.log(bubbleSort(r));

function subStrings(string) {
  let answer = [];
  for (let i = 0; i < string.length; i++) {
    for (let j = i+1; j <= string.length; j++) {
      answer.push(string.substring(i,j));
    }
  }
  return answer;
}

r = "hello";
// console.log(subStrings(r));

// RECURSION EXERCISE
function exp(b, n) {
  if (n === 0) {
    return 1;
  } else {
    return b * exp(b, n-1);
  }
}

// console.log(exp(2, 3));

function fib(n) {
  if (n === 1) {
    return [1];
  } else if (n === 2) {
    return [1,1];
  } else {
    let prev = fib(n-1);
    return prev.concat([prev[prev.length-1] + prev[prev.length-2]]);
  }
}

// console.log(fib(7));

function bSearch(array, target) {
  let half = Math.floor(array.length/2);

  if (array[array.length-1] < target || array[0] > target) {
    return null;
  }

  if (array[half] === target) {
    return half;
  } else if (array[half] > target ) {
    return bSearch(array.slice(0,half), target);
  } else {
    return 1 + half + bSearch(array.slice(half+1, array.length), target);
  }
}

// console.log(bSearch([1,2,3,4,5,6,7,8], 3));

function makeChange(amt, coins) {
  if (amt < coins[coins.length-1]) {
    return null;
  } else if (coins.includes(amt)) {
    return [amt];
  }
  let bestChange = null;
  let currentChange = null;

  coins.forEach(function(coin) {
    let remainder = amt - coin;

    if (remainder >= 0) {
      let coinsLeft = coins.slice(coins.indexOf(coin), coins.length);
      currentChange = [coin].concat(makeChange(remainder, coinsLeft));

      let sumCurrentChange = currentChange.reduce((a,b) => a+b, 0) === amt;
      let betterChange = bestChange === null || currentChange.length < bestChange.length;

      if ( sumCurrentChange && betterChange) {
        bestChange = currentChange;
      }
    }
  });

  return bestChange;
}

// console.log(makeChange(24, [10, 7, 1]));


function merge(left, right) {
  let sorted = [];

  while (left.length > 0 && right.length > 0) {
    if( left[0] < right[0] ) {
      sorted.push(left.shift());
    } else {
      sorted.push(right.shift());
    }
  }
  return sorted.concat(left.concat(right));
}

function mergeSort(array) {
  if (array.length <= 1) { return array; }

  let half = Math.floor(array.length/2);
  let left = array.slice(0, half);
  let right = array.slice(half, array.length);

  return merge(mergeSort(left), mergeSort(right));
}

 // console.log(mergeSort([5,4,3,2,1]));
 // console.log(merge([5],[4]));

 function subsets(array) {
   if (array.length === 0) { return [array]; }
   let num = [array[array.length-1]];
   let answer = subsets(array.slice(0, array.length-1));
   answer.forEach(function(set) {
     answer.push(set.concat(num));
   });
   return answer;
 }

// console.log(subsets([1,2,3]));

//PROTOTYPE EXERCISES

function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function() {
  return `${this.owner} loves ${this.name}`;
};

Cat.prototype.meow = function() {
  return "meow";
};

let cat1 = new Cat("catName", "JS Coder");

cat1.meow = function() { return "not meow"; };
