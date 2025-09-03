require 'telegram/bot'

class TelegramService
  BOT_TOKEN = ENV['TELEGRAM_BOT_TOKEN']
  CHAT_ID = ENV['TELEGRAM_CHAT_ID']

  def self.send_news(news_list)
    Telegram::Bot::Client.run(BOT_TOKEN) do |bot|
      news_list.each_with_index do |news, index|
        title = news[:translated_title] || news[:title]
        summary = news[:translated_summary] || news[:summary]
        
        # Limit summary length to prevent API errors
        summary = summary[0..400] + "..." if summary.length > 400
        
        message = "📰 *خبر #{index + 1}*\n\n"
        message += "*#{title}*\n\n"
        message += "#{summary}\n\n"
        message += "[🔗 ادامه مطلب](#{news[:link]})"
        
        # Send each news as separate message to avoid length issues
        begin
          bot.api.send_message(
            chat_id: CHAT_ID, 
            text: message, 
            parse_mode: 'Markdown',
            disable_web_page_preview: true
          )
          sleep(1) # Rate limiting
        rescue => e
          puts "Error sending message: #{e.message}"
          # Fallback to plain text
          plain_message = message.gsub(/[*_`~>#+\-=|{}.!\\\[\]]/, '')
          bot.api.send_message(chat_id: CHAT_ID, text: plain_message)
        end
      end
    end
  end

  def self.send_message(text)
    Telegram::Bot::Client.run(BOT_TOKEN) do |bot|
      bot.api.send_message(chat_id: CHAT_ID, text: text)
    end
  end

  private

  def self.escape_markdown(text)
    return "" if text.nil? || text.empty?
    # Escape special characters for MarkdownV2
    text.gsub(/[_*\[\]()~`>#+=|{}.!-]/) { |match| "\\#{match}" }
  end
end
