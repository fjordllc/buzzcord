# frozen_string_literal: true

class AvatarUrlMaker
  def self.call(uid, avatar_id, _discriminator)
    if avatar_id
      DiscordApiClient.new.make_avatar_url(uid, avatar_id)
    else
      DiscordApiClient.new.make_default_avatar(uid)
    end
  end
end
