module Api::V1
  class DailyWinnersController < ApiController
    # GET api/v1/daily_winners/today
    def winners_on_date
      date = Date.parse(params[:date])
      winners = DailyWinner.find_by(date: date)
      render status: 200, json: {
        winners: winners
      }.to_json
    end
  end
end
