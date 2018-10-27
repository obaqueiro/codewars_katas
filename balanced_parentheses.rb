def balanced_parens(n)
    res = []
    helper(n,n,res,'')
    return res
 end
 
 def helper(l,r,res,line)
   return if (r < l) 
   return res.push(line) if (l == 0 && r == 0)
   helper(l-1, r, res, line+'(') if (l>0)
   helper(l, r-1, res, line+')') if (r>0)   
 end