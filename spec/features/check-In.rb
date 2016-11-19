require 'spec_helper'
require 'util_tests'

feature 'Check-in' do
  before :all do
    @authentication = FactoryGirl.create(:authentication)    
    @torneo_checkin = FactoryGirl.create(:torneo, vacantes: 16, cierre_inscripcion: Time.new + 120, juego: Juego.find_by(nombre: "Hearthstone"))    
    inscripcion = Inscripcion.create(gamer: @authentication.gamer, torneo: @torneo_checkin, estado: "No Confirmado")
  end

  scenario 'Dado que un torneo está en su etapa de check-in y el Gamer no está en cola, entonces al realizar check-in redirigirá a la pantalla de Jugar torneo'  do
    autenticarse_como_gamer @authentication.gamer.correo 
    print page.html
    within("#seccion_torneo_" + @torneo_checkin.id.to_s) do
      click_button('Check-In')
    end
    expect(page).to have_content('Check-in realizado correctamente')
  end

end



#Dado que un torneo está en su etapa de check-in y el Gamer no está en cola, entonces al confirmar redirigirá a la ficha de torneo iniciado y el mensaje que debe salir es “Tu confirmación se guardó satisfactoriamente”.
#Dado que un torneo está en su etapa de check-in y el Gamer está en cola, entonces al confirmar redirigirá a la ficha de torneo iniciado y el mensaje que debe salir es “Tu confirmación se guardó satisfactoriamente, estás en cola debes esperar a que se libere una vacante”.
#Dado que un torneo inició y el Gamer intenta confirmar, el mensaje que debe salir es “La fase de check-in ya finalizó”.
