require 'httparty'

class TranslatorService
  API_URL = 'https://openrouter.ai/api/v1/chat/completions'
  API_KEY = ENV['OPENROUTER_API_KEY']
  MODEL = 'deepseek/deepseek-chat-v3.1:free' # Or any model, e.g., 'anthropic/claude-3-haiku'

  def self.translate_text(text, target_lang = 'Persian')
    prompt = "Translate the following English text to #{target_lang}: #{text}"
    response = call_api(prompt)
    response.dig('choices', 0, 'message', 'content')&.strip || text
  end

  def self.summarize_text(text)
    prompt = "Summarize the following text in English: #{text}"
    response = call_api(prompt)
    response.dig('choices', 0, 'message', 'content')&.strip || text
  end

  private

  def self.call_api(prompt)
    headers = {
      'Authorization' => "Bearer #{API_KEY}",
      'Content-Type' => 'application/json'
    }
    body = {
      model: MODEL,
      messages: [{ role: 'user', content: prompt }]
    }
    response = HTTParty.post(API_URL, headers: headers, body: body.to_json)
    JSON.parse(response.body)
  end
end
