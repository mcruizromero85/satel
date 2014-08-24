# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inscripcion do
    torneo_id 1
    gamer_id 1
    fecha "2014-08-16"
    hora "2014-08-16 22:35:13"
  end
end
