# frozen_string_literal: true

require 'telegram/bot'
require 'byebug'

TOKEN = '5355602013:AAHa-KLoO1NKi5c8G4oDi2KAXgYLhM69ga0'

ANSWERS = [

  # Позитивні
  'Безперечно',
  'Це однозначно так',
  'Жодних сумнівів',
  'Безумовно так',
  'Можеш бути впевнений у цьому',

  # Нерішуче позитивні
  'Мені здається «так»',
  'Скоріше за все',
  'Хороші перспективи',
  'Знаки кажуть - «так»',
  'Так',

  # Нейтральні
  'Поки не зрозуміло, спробуй знову',
  'Запитай пізніше',
  'Краще не розповідати',
  'Зараз не можна передбачити',
  'Сконцентруйся та запитай знову',

  # Негативні
  'Навіть не думай',
  'Моя відповідь «ні»',
  'За моїми даними - «ні»',
  'Перспективи не дуже добрі',
  'Дуже сумнівно'
].freeze

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::Message
      case message.text
      when '/start', '/start start'
        bot.api.send_message(
          chat_id: message.chat.id,
          text: "Привіт, #{message.from.first_name}"
        )
      else
        bot.api.send_message(
          chat_id: message.chat.id,
          text: ANSWERS.sample
        )
      end
    when Telegram::Bot::Types::PollAnswer
      process_poll_answer(message)
    else
      bot.logger.info('Not sure what to do with this type of message')
    end
  end
end
