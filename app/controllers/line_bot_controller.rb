class LineBotController < ApplicationController
  require "line/bot"

  protect_from_forgery with: :null_session

  def callback
    #LINEで送られてきたメッセージデータ取得
    body = request.body.read
    binding.pry

    #LINE以外からリクエストがきた場合エラーを返す
    signature = request.env["HTTP_X_LINE_SIGANATURE"]
    unless client.validate_signature(body,signature)
      head :bad_request and return
      binding.pry
  end
  #LINEで送られたメッセージを適切な形式に変形
  events = client.parse＿events_from(body)

  events.each do |event|
    #LINEからテキストが送信された時
    if (event.type === Line::Bot::Event::MessageType::Text)
      #Lineからテキストが送信された時の処理を記述
    end
  end

  #LINEのwebhookAPIとの連携をするためにstatus code200を返す
  render json: {status: :ok}
  binding.pry
end

private

def client
  @client ||= Line::Bot::Client.new do |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token =  ENV["LINE_CHANNEL_TOKEN"]
end
end
end

