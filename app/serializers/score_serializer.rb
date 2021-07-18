class ScoreSerializer < ActiveModel::Serializer
  attributes :id,:player, :score, :time

  def player
    "#{object.player.name}"
  end

  def score
    "#{object.score}"
  end

  def time
    "#{object.created_at.strftime('%Y-%m-%d')}"
  end
end
