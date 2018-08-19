function parseInt(string) {
  var values = string.split(' ');
  var total = 0;
  var current = 0;
  const digits = { 
    'one' : 1,  'two' : 2, 'three' : 3, 'four' : 4, 'five' : 5,
    'six' : 6, 'seven' : 7, 'eight' : 8, 'nine' : 9, 'ten' : 10  ,
    'eleven': 11, 'twelve':12, 'thirteen': 13, 'fourteen': 14, 'fifteen': 15,
    'sixteen': 16, 'seventeen': 17, 'eighteen': 18, 'nineteen': 19, 'twenty': 20,
    'thirty': 30, 'forty': 40, 'fifty': 50, 'sixty': 60, 'seventy': 70, 
    'eighty': 80, 'ninety': 90
    }
    var multipliers = { 
      'hundred': 100, 'thousand':1000, 'million': 1000000
      }
    
  while(values.length > 0) {
    var token = values.shift();
    var multiplier = 1;
    if (token == 'zero') { return 0; }    
    if (token == 'and') { continue;}
    if (token.includes('-')) {
      token = token.split('-');
       current += digits[token[0]];
       current += digits[token[1]];
    }
    else {
      current += digits[token];
    }
    
    while( Object.keys(multipliers).includes(values[0]) ) {
     multiplier *= multipliers[values.shift()];
    }
    if (total >= 1000) {  total /=multiplier; }
    total += current;
    total *= multiplier;
    current = 0;
    multiplier = 1;
  }
  return total;
}


// Tests
Test.assertEquals(parseInt('zero'), 0);
Test.assertEquals(parseInt('one million and two'), 1000002);
Test.assertEquals(parseInt('one thousand three hundred and thirty-seven'), 1337);
Test.assertEquals(parseInt('nine hundred twenty-five thousand'), 925000);
Test.assertEquals(parseInt('nine hundred twenty-five thousand seven hundred twenty two'), 925722);

Test.assertEquals(parseInt('one'), 1);
Test.assertEquals(parseInt('forty-six'), 46);
Test.assertEquals(parseInt('seventy-nine'), 79);
Test.assertEquals(parseInt('twenty'), 20);
Test.assertEquals(parseInt('two hundred forty-six'), 246);
