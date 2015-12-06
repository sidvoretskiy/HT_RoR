class CreateSubscriptionsPosts < ActiveRecord::Migration
def change
  create_table :subscriptions_posts do |t|
    t.belongs_to :user, index: true
    t.belongs_to :post, index: true
  end
end
end
