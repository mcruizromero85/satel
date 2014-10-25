# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :encuentro do
    gamera_id 1
    gamerb_id 1
    posicion_en_ronda 1
    id_ronda 1
    flag_ganador "MyString"
    descripcion "MyString"
    encuentro_anterior_a_id 1
    encuentro_anterior_b_id "MyString"
  end
end
