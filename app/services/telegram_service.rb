require 'telegram/bot'

class TelegramService
  BOT_TOKEN = ENV['TELEGRAM_BOT_TOKEN']
  CHAT_ID = ENV['TELEGRAM_CHAT_ID']

  def self.send_news(news_list)
    Telegram::Bot::Client.run(BOT_TOKEN) do |bot|
      message = "Latest News from The Hacker News (Translated to Persian):\n\n"
      news_list.each do |news|
        message += "**#{news[:translated_title]}**\n#{news[:translated_summary]}\n[Read more](#{news[:link]})\n\n"
      end
      bot.api.send_message(chat_id: CHAT_ID, text: message, parse_mode: 'Markdown')
    end
  end

  def self.send_message(text)
    Telegram::Bot::Client.run(BOT_TOKEN) do |bot|
      bot.api.send_message(chat_id: CHAT_ID, text: text)
    end
  end
end
