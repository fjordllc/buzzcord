# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ranks', type: :request do
  describe 'GET /' do
    context 'ログインしていないとき' do
      it 'welcomeページにリダイレクトする' do
        get root_path
        expect(response).to redirect_to(welcome_url)
      end
    end

    context 'ログインしているとき' do
      let(:user) { create(:user) }

      before { sign_in_as_request(user) }

      it '200レスポンスを返す' do
        get root_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  def sign_in_as_request(user)
    OmniAuth.config.mock_auth[:discord] = OmniAuth::AuthHash.new(
      provider: user.provider,
      uid: user.uid,
      info: { name: user.name },
      extra: { raw_info: { discriminator: user.discriminator } }
    )
    stub_request(:get, "#{Discordrb::API.api_base}/guilds/#{ENV['DISCORD_SERVER_ID']}/members/#{user.uid}")
    get '/auth/discord/callback'
  end
end
