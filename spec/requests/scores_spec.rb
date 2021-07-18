require 'rails_helper'

RSpec.describe "Scores api/v1", type: :request do

  # Initialize the test data

  time = DateTime.parse('2021-07-18T10:10:10Z')
  let!(:p2) { create(:player, name: "newton") }
  let!(:p2_score) { create_list(:score, 10, player_id: p2.id).each_with_index do |st, i|
    st.score = i.to_i
    st.created_at = time.days_ago(i)
  end }

  let!(:player) { create(:player, name: "hikaru") }
  let!(:scores) { create_list(:score, 10, player_id: player.id, score: 10) }
  let(:player_id) { player.id }
  let(:score_id) { scores.first.id }

  # Test suite for GET /api/v1/scores
  describe 'GET /api/v1/scores' do
    before { get "/api/v1/scores" }

    context 'when scores exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns 20 scores' do
        expect(json['data'].length).to eq(20)
      end
    end
  end

  # Test suite for POST a/pi/v1/scores
  describe 'POST /api/v1/scores' do
    # valid payload
    let(:valid_attributes) { { player: 'sunny', score: '10', time: DateTime.now } }

    context 'when the request is valid' do
      before { post '/api/v1/scores', params: valid_attributes }

      it 'creates a score' do
        expect(json['player']).to eq('sunny')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/scores', params: { title: 'sunny' } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Unable to create score/)
      end
    end
  end

  # Test suite for GET /api/v1/scores/:id
  describe 'GET /api/v1/scores/:id' do
    before { get "/api/v1/scores/#{score_id}" }

    context 'when the record exists' do
      it 'returns the score' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(score_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when score does not exist' do
      let(:score_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Score/)
      end
    end
  end

  # Test suite for GET /api/v1/scores/history/:player
  describe 'GET /api/v1/scores/history/:player' do
    before { get "/api/v1/scores/history/#{p2.name}" }

    context 'when the record exists' do
      it 'returns the score' do
        expect(json).not_to be_empty
      end
      # it 'return average as 5.7' do
      #   expect(json['average']).to eq("5.7")
      # end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /api/v1/scores/:id
  describe 'DELETE /api/v1/scores/:id' do
    before { delete "/api/v1/scores/#{score_id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
