# encoding: UTF-8


class ReportUserList < Sinatra::Base
  post '/ReportUserList/:uid' do
    #取出前一頁的資料
    uid=params[:uid]
    
    
    #連續資料庫
    database = SQLite3::Database.new("db/CarManager")
    if uid=="all"
      rows = database.execute("select * from userlist")
    else
      rows = database.execute("select * from userlist where uid='#{uid}'")
    end  
      
    
    #串出模版
    template="
    <html>    
    <head>
    <title>使用者明細</title>
    <meta http-equiv='Content-Type' width='1280' height='1024' border='0' content='text/html; charset=utf-8'> 
    </head>
    
    <body background='../waybkgnd.gif'>   
    <p align='center'>
    <font face='MS PMincho' style='font-size: 70pt' color='#0000FF'>使用者明細</font></p>
    <p align='center'><img border='0' src='../0094.gif' width='822' height='36'></p>
    <div align='center'>
      <table border='1' width='85%' id='table1' height='450'>
        <tr>
          <td width='92' align='center' style='border-color: #0000FF' height='55'>
          <span style='font-size: 30pt'><font color=white>權限</font></span></td>
          <td width='151' align='center' style='border-color: #0000FF' height='55'>
          <span style='font-size: 30pt'><font color=white>卡號</font></span></td>
          <td width='106' align='center' style='border-color: #0000FF' height='55'>
          <span style='font-size: 30pt'><font color=white>姓名</font></span></td>
          <td width='154' align='center' style='border-color: #0000FF' height='55'>
          <span style='font-size: 30pt'><font color=white>電話</font></span></td>
          <td width='117' align='center' style='border-color: #0000FF' height='55'>
          <span style='font-size: 30pt'><font color=white>電子郵件</font></span></td>
          <td width='117' align='center' style='border-color: #0000FF' height='55'>
          <span style='font-size: 30pt'><font color=white>帳號</font></span></td>
          <td width='100' align='center' style='border-color: #0000FF' height='55'>
          <span style='font-size: 30pt'><font color=white>密碼</font></span></td>
          <td width='113' align='center' style='border-color: #0000FF' height='55'>
          <span style='font-size: 30pt'><font color=white>餘額</font></span></td>
        </tr>
    "
    
    #取出資料庫的資料   
    rows.each() do |row|
      template+="
        <tr>
            <td width='92' style='border-color: #0000FF'><font color=white>#{row[6]}</font></td>
            <td width='151' style='border-color: #0000FF'><font color=white>#{row[1]}</font></td>
            <td width='106' style='border-color: #0000FF'><font color=white>#{row[4]}</font></td>
            <td width='154' style='border-color: #0000FF'><font color=white>#{row[5]}</font></td>
            <td width='100' style='border-color: #0000FF'><font color=white>#{row[0]}</font></td>
            <td width='117' style='border-color: #0000FF'><font color=white>#{row[2]}</font></td>
            <td width='100' style='border-color: #0000FF'><font color=white>#{row[3]}</font></td>
            <td width='113' style='border-color: #0000FF'><font color=white>#{row[7]}</font></td>
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