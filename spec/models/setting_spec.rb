require 'rails_helper'

RSpec.describe Setting do
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:value).of_type(:string) }
end
