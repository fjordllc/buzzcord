# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RanksCreator, type: :model do
  describe '#call' do
    context '#delete_all Rankのレコードを全削除するとき' do
      it 'RankレコードとともにEmojiとAttachmentレコードも削除される' do
        rank = create(:rank)
        create(:emoji, rank_id: rank.id)
        create(:attachment, rank_id: rank.id)
        expect { Rank.delete_all }
          .to change { Rank.count }.from(1).to(0)
          .and change { Emoji.count }.from(1).to(0)
          .and change { Attachment.count }.from(1).to(0)
      end
    end
    context 'Discord上でメッセージが削除済みのとき' do
      it 'UnknownMessageエラーをスキップして処理を継続する' do
        reaction = create(:reaction)
        allow(RankOrderMaker).to receive(:new).and_return(
          instance_double(RankOrderMaker, each_ranked_message: nil).tap do |dbl|
            allow(dbl).to receive(:each_ranked_message).and_yield([[reaction.channel_id, reaction.message_id], 1], 1)
          end
        )
        allow(RanksCreator).to receive(:call).and_raise(Discordrb::Errors::UnknownMessage.new('Unknown Message'))
        expect { AllRankingDataCreator.call }.not_to raise_error
      end
    end

    context '#一昨日以前のリアクションデータの削除' do
      before do
        create_list(:reaction, 5)
        create_list(:reaction, 4, :reacted_before_yesterday)
        create_list(:reaction, 3, :reacted_today)
      end
      it '昨日と今日のデータのみが残る' do
        expect { Reaction.where('reacted_at < ?', Time.zone.yesterday).delete_all }
          .to change { Reaction.count }.from(12).to(8)
      end
    end
  end
end
