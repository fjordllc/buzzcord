# frozen_string_literal: true

FactoryBot.define do
  factory :rank do
    order { 1 }
    channel_id { 12345 }
    channel_name { '趣味の広場' }
    thread_id { 23456 }
    thread_name { '音楽' }
    message_id { 34567 }
    content { ["音楽が好きだ！"] }
    author_id { 45678 }
    author_name { 'Hana' }
    author_avatar { 'https://cdn.discordapp.com/embed/avatars/3.png' }
    author_discriminator { 5678 }
    posted_at { Time.current }
    total_emojis_count { 20 }
    content_post { '音楽が好きだ！' }
    # association :attachment
  end
end

