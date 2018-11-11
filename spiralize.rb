def spiralize(size)
  arr = Array.new(size) { Array.new(size) {0}}
  n = size 
  row = 0
  col = 0
  
  return [[1]]if size == 1
  return [[1, 1], [0, 1]] if size == 2
  hrz=0
  vert=0
  while (n>0)
    break if (n-vert <=2)
    (n-vert).times { (arr[row][col] = 1); col+=1 }
    hrz+=2 if (hrz>0)
    col-=1
    (n-hrz).times { (arr[row][col] = 1); row+=1 }   
    vert+=2 if (hrz >0)
    row-=1    
    break if (n-vert <=2)
    (n-vert).times {(arr[row][col] = 1) ; col-=1 }
    col+=1
    hrz+=2   
    (n-hrz).times { (arr[row][col] = 1); row-=1 }  
    row+=1
    vert+=2
    break if (n-vert <= 0) || (n-hrz <=0) 
  end
  return arr
end
