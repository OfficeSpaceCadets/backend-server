require 'rails_helper'

RSpec.describe PairingSession do
  it { should have_and_belong_to_many(:users) }
  it { should have_db_column(:start_time).of_type(:datetime) }
  it { should have_db_column(:end_time).of_type(:datetime) }
end
