# encoding: UTF-8


require 'rqrcode'

class GenerateQRCode < Sinatra::Base
  post '/GenerateQRCode/:uid' do
    #產生專屬QR條碼
    @qr = RQRCode::QRCode.new(params[:uid])
    
      
    #串出模版
    template="<style type='text/css'>
    table {
     border-width: 0;
     border-style: none;
     border-color: #0000ff;
     border-collapse: collapse;
    }
    td {
      border-width: 0;
      border-style: none;
      border-color: #0000ff;
      border-collapse: collapse;
      padding: 0;
      margin: 0;
      width: 10px;
      height: 10px;
    }
    td.black { background-color: #000; }
    td.white { background-color: #fff; }
    </style>"
    
    #繪出QR碼
    template+="<table>"
    @qr.modules.each_index() do |x|
      template+="<tr>"
      @qr.modules.each_index() do |y|
       if @qr.dark?(x,y)
         template+="<td class='black'/>"
       else
         template+="<td class='white'/>"
       end
      end
      template+="</tr>"
    end
    template+="</table>"
    
    
    template
  end
end