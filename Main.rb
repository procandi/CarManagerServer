# encoding: UTF-8


#匯入模組
require 'sinatra/base'
require 'sqlite3'
require 'pony'
if RUBY_VERSION=~/1\.9\../
  #require_relative 'Main'
  require_relative 'GenerateQRCode'
  require_relative 'MainUser'
  require_relative 'SaveDollar'
  require_relative 'ReportCheckInOut'
  require_relative 'ReportSaveDollar'
  require_relative 'ReportUserList'
else
  #require 'Main'
  require 'GenerateQRCode'
  require 'MainUser'
  require 'SaveDollar'
  require 'ReportCheckInOut'
  require 'ReportSaveDollar'
  require 'ReportUserList'
end


class Main < Sinatra::Base
  #告訴系統在此模組所需要用到的模組
  use GenerateQRCode
  use MainUser
  use SaveDollar
  use ReportCheckInOut
  use ReportSaveDollar
  use ReportUserList
  
  
  #網頁的進入點
  get '/' do   
    erb :Main
  end
  
  
  #驗證使用者
  post '/verifyuser' do
    #抓出前一頁的資料
    uid=params[:uid]
    upw=params[:upw]
    upower=""
    
    
    #連線資料庫
    database = SQLite3::Database.new("db/CarManager")
    #執行sql
    rows = database.execute("select upower from userlist where uid='#{uid}' and upw='#{upw}'")
        
    #取出權限
    flag=false
    rows.each() do |row|
      upower=row[0]
      flag=true
      break
    end
    
    #判斷權限
    if flag then
      if upower=="管理員"
        erb :MainManager
      else
        #redirect "GenerateQRCode/#{uid}"
        redirect "MainUser/#{uid}"
      end
    else
      redirect :verifyfaild
    end
  end
  
  
  #驗證失敗
  get '/verifyfaild' do
    '<h1>驗證失敗</h1>'
  end
  
  
  #寄出email
  get '/sendemail' do
    #取得資料庫
    database = SQLite3::Database.new("db/CarManager")
    #執行sql
    rows = database.execute("select uemail from userlist where dollar<100")
    list=""
    
    #取出資料並寄出
    rows.each() do |row|
      Pony.mail({
        :from => '校園停車場管理系統',
        :to => row[0],
        :subject => '校園停車場管理系統通知',
        :body => '提醒您，您的餘額即將不足，此為系統發出之郵件，請勿回覆此信件。',
        :via => :smtp,
        :via_options => {
         :address              => 'smtp.gmail.com',
         :port                 => '587',
         :enable_starttls_auto => true,
         :user_name            => 'sameway168@gmail.com',
         :password             => 'samewayq',
         :authentication       => :plain, 
         :domain               => "localhost.localdomain" 
         }
      })
      
      list+=":#{row[0]}"
    end
    
    "寄信成功，清單有#{list}"
  end
  
  
  #run sinatra server when this site is unstart
  run! if app_file == $0
end