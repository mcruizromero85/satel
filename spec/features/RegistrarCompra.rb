require "spec_helper"

feature "Compra de productos" do

	scenario "Dado que he realizado una compra de un producto x con precio y, al finalizar la compra debería ver el total de z", :js => true do
		
		orden_normal = FactoryGirl.build(:orden)
		visit "/ripley-peru"
		click_link('headerLogin')
    	fill_in 'WC_AccountDisplay_FormInput_logonId_In_Logon_1', :with => orden_normal.dni
    	fill_in 'WC_AccountDisplay_FormInput_logonPassword_In_Logon_1', :with => orden_normal.password
    	click_link('WC_AccountDisplay_links_2')	

    	fill_in 'SimpleSearchForm_SearchTerm', :with => orden_normal.sku
		click_link('WC_CachedHeaderDisplay_button_1')	
		click_link('WC_CachedProductOnlyDisplay_links_3')
		find("#total_breakdown").find('#shopcartCheckout').click				
		find(".simulaDesp").first("a").click
		sleep(3)
		page.save_screenshot('screenshot.png')
		find("#shippingBillingPageNext").click
		sleep(3)
		page.save_screenshot('screenshot2.png')
		choose('radio_payMethodId_1_0')		
		#choose('radio_payMethodId_1_1')
		sleep(4)
		page.save_screenshot('screenshot3.png')
		find('#shippingBillingPageNext').click
		sleep(4)
		page.save_screenshot('screenshot4.png')
		find('#link_comprar').click		
    	sleep(5)
    	page.save_screenshot('screenshot5.png')
    	find('#aprobado').click
    	sleep(4)
    	page.save_screenshot('screenshot6.png')

    	find("contenidotablaOCinterior").find("forma_pago_valor").value.to has_content(orden_normal.medio_de_pago)

	end





end