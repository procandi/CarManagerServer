# encoding: UTF-8


class ReportCheckInOut < Sinatra::Base
  post '/ReportCheckInOut/:uid' do
    #取出前一頁的資料
    uid=params[:uid]
    
    #連線資料庫
    database = SQLite3::Database.new("db/CarManager")
    if uid=="all"
      rows = database.execute("select * from checkinout")
    else
      rows = database.execute("select * from checkinout where uid='#{uid}'")
    end  
      
    
    #串出模版
    template="
    <html>
    <head>
    <title>進出口管制</title>
    <meta http-equiv='Content-Type' width='1280' height='1024' border='0' content='text/html; charset=utf-8'> 
    </head>
    
    <body background='../waybkgnd.gif'>
    <p align='center'>
    <font face='MS PMincho' style='font-size: 70pt' color='#0000FF'>進出管制</font></p>
    <p align='center'><img border='0' src='../0094.gif' width='822' height='36'></p>
    <div align='center'>
      <table border='1' width='67%' id='table2' height='450'>
        <tr>
          <td width='121' align='center' style='border-color: #0000FF' height='55'>
          <font face='MS PMincho' style='font-size: 30pt'><font color=white>日期</font></font></td>
          <td width='157' align='center' style='border-color: #0000FF' height='55'>
          <font face='MS PMincho' style='font-size: 30pt'><font color=white>時間</font></font></td>
          <td width='181' align='center' style='border-color: #0000FF' height='55'>
          <font face='MS PMincho' style='font-size: 30pt'><font color=white>ID</font></font></td>
          <td width='199' align='center' style='border-color: #0000FF' height='55'>
          <span style='font-size: 30pt'><font color=white>狀態</font></span></td>
        </tr>
    "
    
    #把資料庫的資料列出來
    rows.each() do |row|
      template+="
        <tr>
          <td width='121' style='border-color: #0000FF'><font color=white>#{row[0]}</font></td>
          <td width='157' style='border-color: #0000FF'><font color=white>#{row[1]}</font></td>
          <td width='181' style='border-color: #0000FF'><font color=white>#{row[4]}</font></td>
          <td width='199' style='border-color: #0000FF'><font color=white>#{row[3]}</font></td>
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