# encoding: UTF-8


class SaveDollar < Sinatra::Base
  post '/ConfirmSaveDollar' do
    #串出模版
    template="
    ﻿﻿<html>
    <head>
    <meta http-equiv='Content-Type' width='1280' height='1024' border='0' content='text/html; charset=utf-8''> 
    <style type='text/css'> 
    h1 {color:white; background-color:blue;} 
    h3 {color:red;} 
    </style> 
    </head>
    
    <body>
    
    <div>
    <h1>RFID校園停車場之應用</h1>
    <h3>古書鳴、洪新傑、黃承雋、胡哲綸 </h3>
    <p>儲值介面.</p>
    
    <form action='/SaveDollar' method='post' accept-charset='utf-8''>
   帳號：<input type='textbox' name=uid value='admin'>
 金額：<input type='textbox' name=adddollar value='100'>
    <input type='submit' value='確定'>
    </form>
    </div>
    <p><b>指導老師 宋志揚. 2013.</b></p>
    </div>

    </body>
    </html>
    "
    
    
    template
  end
    
  
  #儲值
  post '/SaveDollar' do
    #取出前一頁的資料
    uid=params[:uid]
    adddollar=params[:adddollar]
    dollar=0
      
    
    #連續資料庫
    database = SQLite3::Database.new("db/CarManager")
    #執行sql
    rows = database.execute("select dollar from userlist where uid='#{uid}'")
    
    #取出資料
    flag=false
    rows.each() do |row|
      dollar=row[0]
      flag=true
      break
    end
    
    
    if flag then
      resultdollar=dollar.to_i()+adddollar.to_i()  
      database.execute("update userlist set dollar=#{resultdollar} where uid='#{uid}' ")
      if adddollar.to_i()>=0
        database.execute("insert into Dollar(date,time,uid,status,dollar) values('#{DateTime.now.year}/#{DateTime.now.month}/#{DateTime.now.day}','#{DateTime.now.hour}:#{DateTime.now.minute}:#{DateTime.now.second}','#{uid}','存入',#{adddollar}) ")
      else
        database.execute("insert into Dollar(date,time,uid,status,dollar) values('#{DateTime.now.year}/#{DateTime.now.month}/#{DateTime.now.day}','#{DateTime.now.hour}:#{DateTime.now.minute}:#{DateTime.now.second}','#{uid}','扣款',#{adddollar}) ")
      end
      
      "儲值成功，最新餘額為:#{resultdollar}"
    else
      "儲值異常，請確認是否有此帳號或者請再試一次"
    end
  end
end