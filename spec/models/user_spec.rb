require 'rails_helper'

RSpec.describe User do
  it { should have_and_belong_to_many(:pairing_sessions) }
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:username).of_type(:string) }
  it { should have_db_column(:email).of_type(:string) }
end
