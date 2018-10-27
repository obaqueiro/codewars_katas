def eq_dice(set_)
    # your code here    
    
    rem = set_.reduce {|sum,i| sum*i}
    sets = {}
    set = []
    helper(rem, set, sets)
    length = sets.keys.length    
    length -= 1 if (sets.include?(set_.sort.join(','))) 
    return (length)
end

def helper(rem,set, sets)
   return if rem < 3
   if (rem  <= 20)
     
     set2 = set.dup
     set2.push(rem)
     
     sets[set2.sort.join(',')] = 1 if set2.length > 1
   end
   
   (3..20).reverse_each do |i|
     if (rem % i) == 0 
       helper(rem/i,[*set,i], sets)
     end
   end
end
