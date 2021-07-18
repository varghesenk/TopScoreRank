class GenerateHistory
  # capture input parameters
  def initialize(params)
    @pl = params[:hist_params][:player]
  end

  # Service implementation
  def call
    @player = Player.where('lower(name) = ?', @pl.downcase).first
    if @player
      @records = @player.scores.select(:id, 'score', 'created_at AS time')
      @highvalue = @records.order('score DESC').first
      @lowvalue = @records.order('score ASC').last
      OpenStruct.new({ success?: true,
                       player: @player.name,
                       high: @highvalue,
                       low: @lowvalue,
                       average: @records.average(:score),
                       payload: @records })
    else
      OpenStruct.new({ success?: false, payload: nil })
    end
  end
end