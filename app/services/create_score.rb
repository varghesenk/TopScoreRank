class CreateScore

  # capture input parameters
  def initialize(params)
    @pl = params[:create_params][:player]
    @sv = params[:create_params][:score]
    @st = params[:create_params][:time]
  end

  # Service implementation
  def call

    unless is_validate?
      return OpenStruct.new({ success?: false, payload: nil })
    end

    @player = Player.where('lower(name) = ?', @pl.downcase).first
    @player ||= Player.create(:name => @pl.downcase)
    @score = @player.scores.create(:score => @sv, :created_at => @st.to_datetime)
    if @score.save
      OpenStruct.new({ success?: true, payload: @score })
    else
      OpenStruct.new({ success?: false, payload: nil })
    end
  end

  private

  def is_validate?
    if !@pl.nil? && !@pl.empty? && !@sv.nil? && @sv.to_i > 0
      return true
    end
  end

end