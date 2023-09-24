$(document).ready(function() {


    openInfoApp=function(data) {
        $("#info_playerid").empty()
        $("#info_bank").empty()
        $("#info_phonenum").empty()
        $("#info_wallet").empty()
        $("#licenses").empty()
        $("#info_playerid").append(`<br><i style="font-size: 20px;padding-right: 1.5vh;" class="fas fa-id-card" style="padding-right: 1vh;" ></i>` + data.source)
        $("#info_bank").append(`<i  style="font-size: 20px;padding-right: 1.7vh;"class="fas fa-university" data-toggle="tooltip" data-placement="left" title="Coming soon" style="padding-right: 1vh;"></i>` + data.money.bank)
        $("#info_phonenum").append(`<i  style="font-size: 20px;padding-right: 2.2vh;margin-left: 0.3vh;"class="fas fa-mobile" style="padding-right: 1vh;"></i>` + data.charinfo.phone)
        $("#info_wallet").append(`<i  style="font-size: 20px;padding-right: 1.9vh; color: #aaca7c;"class="fas fa-wallet" style="padding-right: 1vh;"></i>$` + data.money.cash)


       if(data.metadata.licences.permit === true) {
        $("#licenses").append(`<p style="font-size: 12px;margin-top: 5%">Permit License <i style="color: #a9c581;float:right;margin-right: 30px;margin-top: 5.75px;" class="fas fa-check-circle"></i></p>`)
       }

       if(data.metadata.licences.driver === true) {
        $("#licenses").append(`<p style="font-size: 12px;margin-top: 5%">Driver License <i style="color: #a9c581;float:right;margin-right: 30px;margin-top: 5.75px;" class="fas fa-check-circle"></i></p>`)
       }

       if(data.metadata.licences.cdl === true) {
        $("#licenses").append(`<p style="font-size: 12px;margin-top: 5%">Commerical Drivers License <i style="color: #a9c581;float:right;margin-right: 30px;margin-top: 5.75px;" class="fas fa-check-circle"></i></p>`)
       }

       if(data.metadata.licences.boating === true) {
        $("#licenses").append(`<p style="font-size: 12px;margin-top: 5%">Boating License <i style="color: #a9c581;float:right;margin-right: 30px;margin-top: 5.75px;" class="fas fa-check-circle"></i></p>`)
       }

       if(data.metadata.licences.business === true) {
        $("#licenses").append(`<p style="font-size: 12px;margin-top: 5%">Business License <i style="color: #a9c581;float:right;margin-right: 30px;margin-top: 5.75px;" class="fas fa-check-circle"></i></p>`)
       }

       if(data.metadata.licences.hunting === true) {
        $("#licenses").append(`<p style="font-size: 12px;margin-top: 5%">Hunting License <i style="color: #a9c581;float:right;margin-right: 30px;margin-top: 5.75px;" class="fas fa-check-circle"></i></p>`)
       }

       if(data.metadata.licences.fishing === true) {
        $("#licenses").append(`<p style="font-size: 12px;margin-top: 5%">Fishing License <i style="color: #a9c581;float:right;margin-right: 30px;margin-top: 5.75px;" class="fas fa-check-circle"></i></p>`)
       }

       if(data.metadata.licences.pilot === true) {
        $("#licenses").append(`<p style="font-size: 12px;margin-top: 5%">Pilots License <i style="color: #a9c581;float:right;margin-right: 30px;margin-top: 5.75px;" class="fas fa-check-circle"></i></p>`)
       }

       if(data.metadata.licences.weapon === true) {
        $("#licenses").append(`<p style="font-size: 12px;margin-top: 5%">Weapons License <i style="color: #a9c581;float:right;margin-right: 30px;margin-top: 5.75px;" class="fas fa-check-circle"></i></p>`)
       }
        
    }

    
})