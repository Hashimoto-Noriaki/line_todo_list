class LineBotController < ApplicationController
  require "line/bot"

  protect_from_forgery with: :null_session

  def callback
    # LINEで送られてきたメッセージのデータを取得
    body = request.body.read
    # LINE以外からリクエストが来た場合 Error を返す
    signature = request.env["HTTP_X_LINE_SIGNATURE"]
    unless client.validate_signature(body, signature)
      head :bad_request and return
    end
    
    # LINEで送られてきたメッセージを適切な形式に変形
    events = client.parse_events_from(body)

    events.each do |event|
      # LINE からテキストが送信された場合
      if (event.type === Line::Bot::Event::MessageType::Text)
        message = event["message"]["text"]
        # binding.pry
      #送信されたメッセージをデータベースに保存するコードを書く
        Task.create(body:message)


         reply_message = {
          type: "text",
           text: "タスク:「#{message}」を登録しました。" #LINEに返すメッセージを考える
       }
      client. reply_message(event["replyToken"],reply_message)
      
    # LINE からテキストが送信されたときの処理を記述する
      end
    end

    # LINE の webhook API との連携をするために status code 200 を返す
    render json: { status: :ok }
  end

  private

    def client
      @client ||= Line::Bot::Client.new do |config|
        config.channel_secret = "f030b9e238821a554d76fe4fbd06b6c9"
        config.channel_token = "AE6xU3HH7yISXOLokpjRo6udQkirD2ED49ly46Q9zXPTcCxMAXB50mKfxr3m7gN5gVAaa0+EGuxPXSrPUnQXe12jKLLIB2EaNV7emh5KbgYor6c8V3rR0x9GWz9MwMITKkYcgUGlqMiB86XBeLiEzAdB04t89/1O/w1cDnyilFU="
      end
    end
end
