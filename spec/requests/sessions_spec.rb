# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create(:user) }

  describe 'GET /auth/discord/callback' do
    before do
      OmniAuth.config.mock_auth[:discord] = OmniAuth::AuthHash.new(
        provider: user.provider,
        uid: user.uid,
        info: { name: user.name },
        extra: { raw_info: { discriminator: user.discriminator } }
      )
      stub_request(:get, "#{Discordrb::API.api_base}/guilds/#{ENV['DISCORD_SERVER_ID']}/members/#{user.uid}")
    end

    it 'ログイン後にroot_pathへリダイレクトする' do
      get '/auth/discord/callback'
      expect(response).to redirect_to(root_path)
    end

    it 'セッションにuser_idが設定される' do
      get '/auth/discord/callback'
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe 'DELETE /logout' do
    before do
      OmniAuth.config.mock_auth[:discord] = OmniAuth::AuthHash.new(
        provider: user.provider,
        uid: user.uid,
        info: { name: user.name },
        extra: { raw_info: { discriminator: user.discriminator } }
      )
      stub_request(:get, "#{Discordrb::API.api_base}/guilds/#{ENV['DISCORD_SERVER_ID']}/members/#{user.uid}")
      get '/auth/discord/callback'
    end

    it 'welcomeページへリダイレクトする' do
      delete logout_path
      expect(response).to redirect_to(welcome_path)
    end

    it 'セッションがリセットされる' do
      delete logout_path
      expect(session[:user_id]).to be_nil
    end
  end

end
