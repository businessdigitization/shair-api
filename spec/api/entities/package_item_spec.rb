require 'rails_helper'

RSpec.describe API::Entities::PackageItem do
  let(:package_item) { FactoryBot.create(:package_item) }
  let(:package_item_entity) { API::Entities::PackageItem.represent(package_item) }

  subject { JSON.parse(package_item_entity.to_json) }

  it 'matches the api specification' do
    expect(subject).
      to eq(
        'id' => package_item.id,
        'name' => package_item.name,
        'description' => package_item.description,
        'count' => package_item.count,
      )
  end
end
