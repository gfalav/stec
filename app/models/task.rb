class Task < ActiveRecord::Base
  belongs_to :account
  
  def getavance(account, fini, ffin, namerad)
    
    h = Hash.new
    
    h.store("name",namerad + account.name)
    h.store("account",account)

    for n in 1..12
      f1 = Date.new(fini.year,n.to_i,1)
      f2 = Date.new(fini.year,n.to_i,1).next_month-1
      
      t = Task.where(:account_id=>account.id,:dtask=>f1..f2)[0]

      if (t!= nil)
        if (t.tplan != nil)
          h.store("m"+n.to_s, t.treal.to_i.to_s + '/' + t.tplan.to_i.to_s + '<br/>' + (t.treal.to_f/t.tplan.to_f).round(1).to_s + '%')
          h.store("t"+n.to_s, t)
          h.store("s"+n.to_s, colorbg((t.treal/t.tplan*100).round(0)))
        else
          h.store("m"+n.to_s, t.treal.to_i.to_s + '/' + t.tplan.to_i.to_s)
          h.store("t"+n.to_s, t)
        end
      else
        h.store("m"+n.to_s, 's/t')
      end
    end
    
    return h
  end
  
  def getavanceacum(account,fini,ffin, namerad)
    h = Hash.new
    h.store("name",namerad + account.name)
    h.store("account",account)
    
    m = Task.group('extract(month from dtask)').where(:account_id=>account.descendant_ids << account.id,:dtask=>(fini..ffin)).sum(:treal)
    n = Task.group('extract(month from dtask)').where(:account_id=>account.descendant_ids << account.id,:dtask=>(fini..ffin)).sum(:tplan)

    if (n['1']!=0)
      h['m1'] = m['1'].to_i.to_s + '/' + n['1'].to_i.to_s + "<br/>" + (m['1']/n['1']*100).round(0).to_s+'%'
      h['s1'] = colorbg((m['1']/n['1']*100).round(0)) 
    else
      h['m1'] = m['1'].to_i.to_s + '/' + n['1'].to_i.to_s + "<br/>" + 0.to_s+'%'
      h['s1'] = 'datos'
    end
    if (n['2']!=0)
      h['m2'] = m['2'].to_i.to_s + '/' + n['2'].to_i.to_s + "<br/>" + (m['2']/n['2']*100).round(0).to_s+'%'
      h['s2'] = colorbg((m['2']/n['2']*100).round(0)) 
    else
      h['m2'] = m['2'].to_i.to_s + '/' + n['2'].to_i.to_s + "<br/>" + 0.to_s+'%'
      h['s2'] = 'datos'
    end
    if (n['3']!=0)
      h['m3'] = m['3'].to_i.to_s + '/' + n['3'].to_i.to_s + "<br/>" + (m['3']/n['3']*100).round(0).to_s+'%'
      h['s3'] = colorbg((m['3']/n['3']*100).round(0)) 
    else
      h['m3'] = m['3'].to_i.to_s + '/' + n['3'].to_i.to_s + "<br/>" + 0.to_s+'%'
      h['s3'] = 'datos'
    end
    if (n['4']!=0)
      h['m4'] = m['4'].to_i.to_s + '/' + n['4'].to_i.to_s + "<br/>" + (m['4']/n['4']*100).round(0).to_s+'%'
      h['s4'] = colorbg((m['4']/n['4']*100).round(0)) 
    else
      h['m4'] = m['4'].to_i.to_s + '/' + n['4'].to_i.to_s + "<br/>" + 0.to_s+'%'
      h['s4'] = 'datos'
    end
    if (n['5']!=0)
      h['m5'] = m['5'].to_i.to_s + '/' + n['5'].to_i.to_s + "<br/>" + (m['5']/n['5']*100).round(0).to_s+'%'
      h['s5'] = colorbg((m['5']/n['5']*100).round(0)) 
    else
      h['m5'] = m['5'].to_i.to_s + '/' + n['5'].to_i.to_s + "<br/>" + 0.to_s+'%'
      h['s5'] = 'datos'
    end
    if (n['6']!=0)
      h['m6'] = m['6'].to_i.to_s + '/' + n['6'].to_i.to_s + "<br/>" + (m['6']/n['6']*100).round(0).to_s+'%'
      h['s6'] = colorbg((m['6']/n['6']*100).round(0)) 
    else
      h['m6'] = m['6'].to_i.to_s + '/' + n['6'].to_i.to_s + "<br/>" + 0.to_s+'%'
      h['s6'] = 'datos'
    end
    if (n['7']!=0)
      h['m7'] = m['7'].to_i.to_s + '/' + n['7'].to_i.to_s + "<br/>" + (m['7']/n['7']*100).round(0).to_s+'%'
      h['s7'] = colorbg((m['7']/n['7']*100).round(0)) 
    else
      h['m7'] = m['7'].to_i.to_s + '/' + n['7'].to_i.to_s + "<br/>" + 0.to_s+'%'
      h['s7'] = 'datos'
    end
    if (n['8']!=0)
      h['m8'] = m['8'].to_i.to_s + '/' + n['8'].to_i.to_s + "<br/>" + (m['8']/n['8']*100).round(0).to_s+'%'
      h['s8'] = colorbg((m['8']/n['8']*100).round(0)) 
    else
      h['m8'] = m['8'].to_i.to_s + '/' + n['8'].to_i.to_s + "<br/>" + 0.to_s+'%'
      h['s8'] = 'datos'
    end
    if (n['9']!=0)
      h['m9'] = m['9'].to_i.to_s + '/' + n['9'].to_i.to_s + "<br/>" + (m['9']/n['9']*100).round(0).to_s+'%'
      h['s9'] = colorbg((m['9']/n['9']*100).round(0)) 
    else
      h['m9'] = m['9'].to_i.to_s + '/' + n['9'].to_i.to_s + "<br/>" + 0.to_s+'%'
      h['s9'] = 'datos'
    end
    if (n['10']!=0)
      h['m10'] = m['10'].to_i.to_s + '/' + n['10'].to_i.to_s + "<br/>" + (m['10']/n['10']*100).round(0).to_s+'%'
      h['s10'] = colorbg((m['10']/n['10']*100).round(0)) 
    else
      h['m10'] = m['10'].to_i.to_s + '/' + n['10'].to_i.to_s + "<br/>" + 0.to_s+'%'
      h['s10'] = 'datos'
    end
    if (n['11']!=0)
      h['m11'] = m['11'].to_i.to_s + '/' + n['11'].to_i.to_s + "<br/>" + (m['11']/n['11']*100).round(0).to_s+'%'
      h['s11'] = colorbg((m['11']/n['11']*100).round(0)) 
    else
      h['m11'] = m['11'].to_i.to_s + '/' + n['11'].to_i.to_s + "<br/>" + 0.to_s+'%'
      h['s11'] = 'datos'
    end
    if (n['12']!=0)
      h['m12'] = m['12'].to_i.to_s + '/' + n['12'].to_i.to_s + "<br/>" + (m['12']/n['12']*100).round(0).to_s+'%'
      h['s12'] = colorbg((m['12']/n['12']*100).round(0)) 
    else
      h['m12'] = m['12'].to_i.to_s + '/' + n['12'].to_i.to_s + "<br/>" + 0.to_s+'%'
      h['s12'] = 'datos'
    end
    if (n['1']+n['2']+n['3']+n['4']+n['5']+n['6']+n['7']+n['8']+n['9']+n['10']+n['11']+n['12'])!=0
      h['tot'] = (m['1']+m['2']+m['3']+m['4']+m['5']+m['6']+m['7']+m['8']+m['9']+m['10']+m['11']+m['12']).to_i.to_s + '/'
      h['tot'] = h['tot'] + (n['1']+n['2']+n['3']+n['4']+n['5']+n['6']+n['7']+n['8']+n['9']+n['10']+n['11']+n['12']).to_i.to_s + "<br/>"
      h['tot'] = h['tot'] + ((m['1']+m['2']+m['3']+m['4']+m['5']+m['6']+m['7']+m['8']+m['9']+m['10']+m['11']+m['12'])/(n['1']+n['2']+n['3']+n['4']+n['5']+n['6']+n['7']+n['8']+n['9']+n['10']+n['11']+n['12'])*100).round(0).to_s+'%'
      h['stot'] = colorbg(((m['1']+m['2']+m['3']+m['4']+m['5']+m['6']+m['7']+m['8']+m['9']+m['10']+m['11']+m['12'])/(n['1']+n['2']+n['3']+n['4']+n['5']+n['6']+n['7']+n['8']+n['9']+n['10']+n['11']+n['12'])*100).round(0))
    else
      h['tot'] = 0.to_s+'%'
      h['stot'] = 'datos'
    end
    
    return h
  end

  def getavanceonlytask(account, fini, ffin, namerad)

    h = Hash.new
    
    h.store("name",namerad + account.name)
    h.store("account",account)
    
    for n in 1..12
        h.store("m"+n.to_s, '')
    end
    
    return h
  end
  
  def colorbg(valor)
    rta = case (valor)
      when -1..80 then 'datosred'
      when 81..99 then 'datosyellow'
      when 100..999999 then 'datosgreen'
    end
    return rta
 end
end
