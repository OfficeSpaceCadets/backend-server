require 'rails_helper'

RSpec.describe ApiToken do
  it { should have_db_column(:token).of_type(:string) }
end
