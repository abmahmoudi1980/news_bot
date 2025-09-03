# News Bot

A Ruby on Rails application that scrapes the latest 5 news from https://thehackernews.com/, translates them to Persian using OpenRouter API, and sends them to a Telegram bot. It runs every 6 hours and allows users to request the latest news via commands.

## Setup

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Set up the database:
   ```bash
   rails db:migrate
   ```

3. Configure environment variables in `.env`:
   ```
   TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here
   TELEGRAM_CHAT_ID=your_chat_id_here
   OPENROUTER_API_KEY=your_openrouter_api_key_here
   ```

   - Get Telegram Bot Token: Create a bot with @BotFather on Telegram.
   - Get Chat ID: Send a message to your bot and check updates via `https://api.telegram.org/bot<TOKEN>/getUpdates`.
   - Get OpenRouter API Key: Sign up at https://openrouter.ai/ and get your API key.

4. Run the bot:
   ```bash
   rails bot:run
   ```
   Or directly:
   ```bash
   ./bin/news_bot
   ```

## Features

- Scrapes latest 5 news from The Hacker News.
- Translates titles and summaries to Persian using AI.
- Sends translated news to Telegram every 6 hours.
- Responds to `/latest` command for on-demand news.
- Stores news in SQLite database.

## Dependencies

- Rails 8
- Nokogiri for scraping
- Telegram Bot Ruby for Telegram integration
- HTTParty for API calls
- Rufus-Scheduler for scheduling
- Dotenv-Rails for environment variables

## Notes

- Ensure the site structure hasn't changed; update selectors in `ScraperService` if needed.
- The bot uses OpenRouter's GPT-3.5-turbo by default; change in `TranslatorService` if desired.
- For production, consider using a more robust scheduler like Sidekiq.
