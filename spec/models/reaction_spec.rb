# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reaction, type: :model do
  describe 'ファクトリ' do
    it '有効なファクトリがあること' do
      expect(build(:reaction)).to be_a(Reaction)
    end

    it ':remove トレイトはpointが-1であること' do
      expect(build(:reaction, :remove).point).to eq(-1)
    end
  end

  describe 'データ保存' do
    it 'point が正の値で保存できる' do
      reaction = create(:reaction, point: 1)
      expect(reaction.point).to eq(1)
    end

    it 'point が負の値（スタンプ削除）で保存できる' do
      reaction = create(:reaction, point: -1)
      expect(reaction.point).to eq(-1)
    end

    it 'emoji_id が空文字のときnilで保存される（カスタム絵文字以外）' do
      reaction = create(:reaction, emoji_id: '')
      expect(reaction.emoji_id).to be_nil
    end
  end

  describe 'スコープ' do
    before do
      create_list(:reaction, 2)
      create_list(:reaction, 3, :reacted_today)
      create_list(:reaction, 2, :reacted_before_yesterday)
    end

    it '昨日のリアクションのみ絞り込める' do
      yesterday_reactions = Reaction.where(reacted_at: Time.zone.yesterday.all_day)
      expect(yesterday_reactions.count).to eq(2)
    end

    it '一昨日以前のリアクションを削除できる' do
      expect { Reaction.where('reacted_at < ?', Time.zone.yesterday).delete_all }
        .to change(Reaction, :count).from(7).to(5)
    end
  end
end
