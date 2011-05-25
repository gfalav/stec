class Task < ActiveRecord::Base
  belongs_to :account
  
  def getavance(account, fini, ffin, namerad)
    
    h = Hash.new
    
    h[:name] = namerad + account.name

    for n in 1..12
      f1 = Date.new(fini.year,n,1)
      f2 = Date.new(fini.year,n,1).next_month-1
      
      t = Task.where(:account_id=>account.id,:dtask=>f1..f2)[0]
      
      if (t!= nil && t.tplan !=0)
        h.store(n.to_s, t.treal)
      end
    end
    
    return h
  end
end
