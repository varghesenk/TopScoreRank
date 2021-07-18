class Api::V1::ScoresController < ApplicationController
  before_action :find_score, only: [:show, :destroy]
  after_action { pagy_headers_merge(@pagy) if @pagy }

  # GET /todos/:todo_id/items
  def index

    @records = Score.all
    if params[:created_after].present?
      @records = @records.created_after(params[:created_after])
    end
    if params[:created_before].present?
      @records = @records.created_before(params[:created_before])
    end
    if params[:player].present? and @records
      @names = params[:player].map(&:downcase)
      @records = @records.of_players(@names)
    end

    @pagy, @records = pagy(@records)
    render json: {
      data: ActiveModel::Serializer::CollectionSerializer.new(
      @records, serializer: ScoreSerializer),
      meta: pagy_metadata(@pagy)
    }
  end

  # GET /scores/:id
  def show

    if @score
      render json: @score
    else
      render json: { error: "Score not found" }, status: :not_found
    end
  end

  # POST /scores
  def create
    result = CreateScore.new({
                               create_params:{
                                  player: params[:player],
                                   score: params[:score],
                                  time: params[:time]
                               }
                             }).call
    if result.success?
      render json: result.payload, status: :created
    else
      render json: {error: "Unable to create score"}, status: :bad_request
    end
  end

  # DELETE /scores/:id
  def destroy
    if @score
      @score.destroy
      render json: {message:"Score deleted"}, status: :ok
    else
      render json: {error: "Score not found"}, status: :not_found
    end
  end

  # GET /scores/history/:player
  def history
    result = GenerateHistory.new({
                                   hist_params:{
                                 player: params[:player]
                               }
                             }).call
    if result.success?
      @pagy, @records = pagy(result.payload)

      render json: {
        player: result.player,
        high: result.high,
        low: result.low,
        average: result.average,
        data: @records,
        meta: pagy_metadata(@pagy)
      }
    else
      render json: {error: "Player not found"}, status: :not_found
    end
  end

  private

  def find_score
    @score = Score.find(params[:id])
  end
end
