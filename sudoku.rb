

def sudoku(puzzle)
  fail('invalid sudoku') if puzzle.length != 9

  # check sanity of sudoku
  puzzle.each {|r| fail("invalid puzzle") if invalid_row(r)}
  (0..9).each {|i| fail("invalid puzzle") if invalid_row(col_arr(puzzle,i))}
  (0..3).each {|i| (0..3).each{|j| fail("invalid puzzle") if invalid_row(square_arr(puzzle,i,j))}}

  puts puzzle.map{|r| r.join(" ")}.join("\n")
  solution = _sudoku(puzzle.map {|f| f.length == 9 ? f.dup : fail('invalid sudoku')})
  puts("Solution:")
  puts solution.map{|r| r.join(" ")}.join("\n")
  puts
  return solution
end

def _sudoku(puzzle)
      # while 0s remain
      while puzzle.map {|row| count0s(row)}.sum > 0
      row_index = 0
      col_index = 0
      digits_count = puzzle.length
        puzzle.each_with_index do |row,row_i|
          if(count0s(row) > 0)
            i,c = col_with_less_0s(puzzle,row,row_i)
            if (c < digits_count )
                row_index = row_i
                col_index = i
                digits_count = c
            end
          end
        end

        
        fail("invalid puzzle") if digits_count ==  0 || digits_count == puzzle.length
        fail("invalid puzzle") if invalid_row(puzzle[row_index])
        fail("invalid puzzle") if invalid_row(col_arr(puzzle,col_index))
        fail("invalid puzzle") if invalid_row(square_arr(puzzle,row_index,col_index))

        digits = [*1..9] - puzzle[row_index] -  col_arr(puzzle,col_index) - square_arr(puzzle,row_index,col_index)
        
        failed = 0
        digits.each do |digit| 
          begin
            puzzle[row_index][col_index] = digit
             return _sudoku(puzzle)
          rescue => ex
            puzzle[row_index][col_index] = 0
            failed +=1
          end
        end
        fail('invalid') if( failed == digits.length)
      end
      return puzzle
  end


  def count0s(array)
    return array.reduce(0) {|sum, i|  ( i==0 ? sum+1 : sum) }
  end

  def col_with_less_0s(puzzle,row,row_i)
    indexes = row.each_with_index.map{|x,i| x == 0 ?  i:nil }.compact
    arr = indexes.map{|i| [col_arr(puzzle,i), square_arr(puzzle,row_i,i)]}.map {|cels| ([*1..9] - cels[0] - cels[1] - row).count }
    x = arr.each_with_index.min
    return [indexes[x[1]],x[0]]
  end

  def col_arr(puzzle,index)
      puzzle.map {|item| item[index]}
  end

  def square_arr(puzzle,row_i,col_i)
    init_row = row_i/3  * 3 
    init_col = col_i/3 * 3 
    arr = []
    (init_row..init_row+2).each{|row|(init_col..init_col+2).each{|col|arr.push(puzzle[row][col])}}
    return arr
  end

  def invalid_row(arr)
      return true if (arr - [nil] - [*0..9]).length > 0
      return (arr - [0]).detect{ |e| arr.count(e) > 1 }
  end

    puzzle = [
        [5,3,0,0,7,0,0,0,0],
        [6,0,0,1,9,5,0,0,0],
        [0,9,8,0,0,0,0,6,0],
        [8,0,0,0,6,0,0,0,3],
        [4,0,0,8,0,3,0,0,1],
        [7,0,0,0,2,0,0,0,6],
        [0,6,0,0,0,0,2,8,0],
        [0,0,0,4,1,9,0,0,5],
        [0,0,0,0,8,0,0,7,9]]

        puzzle2 = [
  [5, 6, 0, 8, 4, 7, 0, 0, 0], 
  [3, 0, 9, 0, 0, 0, 6, 0, 0], 
  [0, 0, 8, 0, 0, 0, 0, 0, 0], 
  [0, 1, 0, 0, 8, 0, 0, 4, 0], 
  [7, 9, 0, 6, 0, 2, 0, 1, 8], 
  [0, 5, 0, 0, 3, 0, 0, 9, 0], 
  [0, 0, 0, 0, 0, 0, 2, 0, 0], 
  [0, 0, 6, 0, 0, 0, 8, 0, 7], 
  [0, 0, 0, 3, 1, 6, 0, 5, 9]]


puzzle3 = [
  [8, 0, 0, 0, 6, 0, 0, 0, 3], 
  [4, 0, 0, 8, 0, 3, 0, 0, 1], 
  [7, 0, 0, 0, 2, 0, 0, 0, 6], 
  [0, 6, 0, 0, 0, 0, 2, 8, 0], 
  [0, 0, 0, 4, 1, 9, 0, 0, 5], 
  [0, 0, 0, 0, 8, 0, 0, 7, 9], 
  [5, 3, 0, 0, 7, 0, 0, 0, 0], 
  [6, 0, 0, 1, 9, 5, 0, 0, 0], 
  [0, 9, 8, 0, 0, 0, 0, 6, 0]] 


  # invalid sudoku
puzzle4 = [[1, 1, 3, 4, 5, 6, 7, 8, 9], 
[4, 0, 6, 7, 8, 9, 1, 2, 3], [
  7, 8, 9, 1, 2, 3, 4, 5, 6], 
  [2, 3, 4, 5, 6, 7, 8, 9, 1], 
  [5, 6, 7, 8, 9, 1, 2, 3, 4], 
  [8, 9, 1, 2, 3, 4, 5, 6, 7], 
  [3, 4, 5, 6, 7, 8, 9, 1, 2], 
  [6, 7, 8, 9, 1, 2, 3, 4, 5], 
  [9, 1, 2, 3, 4, 5, 6, 7, 8]]
puzzle5 = [[1, 2, 3, 4, 5, 6, 7, 8, 9], 
[2, 3, 4, 5, 6, 7, 8, 9, 1], 
[3, 4, 5, 6, 7, 8, 9, 1, 2], 
[4, 5, 6, 7, 8, 9, 1, 2, 3], 
[5, 6, 7, 8, 9, 1, 2, 3, 4], 
[6, 7, 8, 9, 1, 2, 3, 4, 5], 
[7, 8, 9, 1, 2, 3, 4, 5, 6], 
[8, 9, 1, 2, 3, 4, 5, 6, 7], 
[9, 1, 2, 3, 4, 5, 6, 7, 8]]

puzzle6 = [[8, 0, 7, 0, 1, 0, 5, 0, 4], [0, 0, 0, 5, 0, 0, 7, 0, 0], [0, 5, 0, 0, 0, 7, 0, 3, 0], [5, 0, 0, 0, 0, 0, 3, 0, 0], [0, 6, 0, 8, 0, 2, 0, 4, 0], [0, 0, 1, 0, 0, 0, 0, 0, 5], [0, 1, 0, 3, 2, 0, 0, 7, 0], [0, 0, 2, 0, 0, 4, 0, 0, 0], [3, 0, 4, 0, 7, 0, 6, 0, 9]]
puzzle7 = [[3, 4, 7, 9, 0, 0, 0, 8, 0], [0, 1, 0, 8, 0, 0, 0, 5, 0], [0, 0, 0, 0, 0, 0, 0, 1, 0], [0, 0, 0, 5, 0, 0, 0, 0, 8], [0, 0, 0, 4, 0, 8, 0, 0, 0], [6, 0, 0, 0, 0, 3, 0, 0, 0], [0, 7, 0, 0, 0, 0, 0, 0, 0], [0, 8, 0, 0, 0, 5, 0, 3, 0], [0, 5, 0, 0, 0, 4, 2, 7, 9]]  
sudoku(puzzle7)
  #sudoku(puzzle)
  #sudoku(puzzle2)
  #sudoku(puzzle3)
        
  
