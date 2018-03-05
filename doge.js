function recaman (nth) { 
  var seen = new Array(0);
  seen.push(0);
  
  for ( var n  = 1 ; n  < nth+1 ; n  += 1 ) {
  var later = n-1;
  var spot = seen[later];
  var lower = spot-n;
  var big = spot+n;
      
  if (lower  > 0  && !seen.includes(lower) ) {
  seen.push(lower);
  } else {
  seen.push(big);
  } 
  
  } 
  
  var place = seen[nth];
  console.log(place);
  
  return place;
  } 

  recaman(1005);