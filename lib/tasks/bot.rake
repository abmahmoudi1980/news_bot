namespace :bot do
  desc 'Run the news bot'
  task run: :environment do
    require_relative '../../bin/news_bot'
  end
end
