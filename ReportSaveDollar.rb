# encoding: UTF-8


class ReportSaveDollar < Sinatra::Base
  post '/ReportSaveDollar/:uid' do
    #取出前一頁的資料
    uid=params[:uid]
    
    #連續資料庫
    database = SQLite3::Database.new("db/CarManager")
    if uid=="all"
      rows = database.execute("select * from dollar")
    else
      rows = database.execute("select * from dollar where uid='#{uid}'")
    end  
      
    
    #串出模版
    template="
    <html>
    <head>
    <title>交易明細</title>
    <meta http-equiv='Content-Type' width='1280' height='1024' border='0' content='text/html; charset=utf-8'> 
    </head>
    
    <body background='../waybkgnd.gif'>
    <p align='center'>
    <font face='MS PMincho' style='font-size: 70pt' color='#0000FF'>交易明細</font></p>
    <p align='center'><img border='0' src='../0094.gif' width='822' height='36'></p>
    <div align='center'>
      <table border='1' width='76%' id='table1' height='450'>
        <tr>
          <td width='127' align='center' style='border-color: #0000FF' height='55'>
          <font face='MS PMincho' style='font-size: 30pt'><font color=white>日期</font></td>
          <td width='141' align='center' style='border-color: #0000FF' height='55'>
          <font face='MS PMincho' style='font-size: 30pt'><font color=white>時間</font></td>
          <td width='152' align='center' style='border-color: #0000FF' height='55'>
          <font face='MS PMincho' style='font-size: 30pt'><font color=white>ID</font></td>
          <td width='170' align='center' style='border-color: #0000FF' height='55'>
          <font face='MS PMincho' style='font-size: 30pt'><font color=white>存取</font></td>
          <td align='center' style='border-color: #0000FF' height='55'>
          <font face='MS PMincho' style='font-size: 30pt'><font color=white>金額</font></td>
        </tr>
    "
       
    #取出資料庫的資料
    rows.each() do |row|
      template+="
        <tr>
          <td width='127' style='border-color: #0000FF'><font color=white>#{row[0]}</font></td>
          <td width='141' style='border-color: #0000FF'><font color=white>#{row[1]}</font></td>
          <td width='152' style='border-color: #0000FF'><font color=white>#{row[2]}</font></td>
          <td width='170' style='border-color: #0000FF'><font color=white>#{row[3]}</font></td>
          <td style='border-color: #0000FF'><font color=white>#{row[4]}</td>
        </tr>
      "
    end
    
    #串出模版
    template+=" 
      </table>
    </div>
    </body>
    </html>
    "
    
    
    template
  end
end