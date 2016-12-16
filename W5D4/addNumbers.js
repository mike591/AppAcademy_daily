const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallBack) {

  if (numsLeft > 0) {
    reader.question('Enter a number', function(answer) {
      sum += parseInt(answer);
      console.log(sum);
      numsLeft -= 1;
      addNumbers(sum, numsLeft, completionCallBack );
    });
  } else {
    completionCallBack(sum);
    reader.close();
  }
}


addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));
