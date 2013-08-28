# encoding: UTF-8


class MainUser < Sinatra::Base
  #User Menu
  get '/MainUser/:uid' do
    #取出前一頁的資料
    uid=params[:uid]
    
    
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
    <p>功能清單.</p>
     
    <form action='/GenerateQRCode/#{uid}' method='post' accept-charset='utf-8'>
    <input type='submit' value='產生專屬條碼'>
    </form>
    <form action='/ReportCheckInOut/#{uid}' method='post' accept-charset='utf-8'>
    <input type='submit' value='車輛進出明細'>
    </form>
    <form action='/ReportSaveDollar/#{uid}' method='post' accept-charset='utf-8'>
    <input type='submit' value='交易明細'>
    </form>
    </div>
    <p><b>指導老師 宋志揚. 2013.</b></p>
    </div>

    </body>
    </html>
    "
  end
end