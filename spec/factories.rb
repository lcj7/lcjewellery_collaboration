FactoryGirl.define do
  factory :meeting do
    is_locked { false }
    session_ident { Forgery(:basic).text }
    name { Forgery(:basic).text }
    max_size { 2 }
    current_size { Forgery(:basic).number }
  end
end