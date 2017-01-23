require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe MostActiveUsersJob, type: :job do

  it 'perform and queue job' do
    job =MostActiveUsersJob.perform_later
    expect(job.job_id.present?).to eq true
  end
end
