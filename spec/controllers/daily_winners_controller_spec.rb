require 'rails_helper'

describe Api::V1::DailyWinnersController, type: :controller do

  context 'with a existing report' do
    let(:daily_winner) { create(:daily_winner, date: Date.today, users: "[[1,10][2,15][3,20]]") }
    it 'responds with a 200 status' do
      post :winners_on_date, params: { date: daily_winner.date }
      expect(response.status).to eq 200
    end
    it 'responds with the daily_winner json' do
      post :winners_on_date, params: { date: daily_winner.date }
      json_data = JSON.parse response.body
      expect(json_data["winners"]["date"]).to eq daily_winner.date.to_s
      expect(json_data["winners"]["users"]).to eq daily_winner.users
    end
  end
end

