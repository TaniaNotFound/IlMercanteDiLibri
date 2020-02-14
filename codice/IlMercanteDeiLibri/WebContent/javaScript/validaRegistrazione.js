$(document).ready(function()
{
  $('#f1').submit(function()
  {
    return validateForm();
  });
});

function cleanError()
{
  $('#f1').find( 'input[type!="submit"]' ).each(function () {
    if(window.innerWidth <= 500)
    {
      $("span").remove();
      $(".login-box").css("height","920px")
    }
    else
    {
      $("span").remove();
      $(".login-box").css("height","615px")
    }
  });
}

function error(id, errore)
{
      if(window.innerWidth <= 500)
      {
        alert(errore);
        $(".login-box").css("height","970px")
      }
      else
      {
       alert(errore);
        $(".login-box").css("height","655px")
      }
}

function validateName(nome)
{
  var letters = /^[A-Za-z\s]+$/;
  if(nome.match(letters) )
    return true;
  else
    return false;
}

function validateSurname(cognome)
{
  var letters = /^[A-Za-z\s]+$/;
  if(cognome.match(letters) )
    return true;
  else
    return false;
}

function ValidateEmail(email)
{
   var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
   if(email.match(mailformat))
         return true;
   else
         return false;
}


function ValidatePassword(password)
{
  var passwordformat= /^([A-Za-z0-9]){8,16}$/;

  if(password.match(passwordformat))
  {
    return true;
  }
  else
  {
    return false;
  }
}
function validateZipCode(zipCode)
{
  var numberformat= /^([0-9]){5}$/;

  if(zipCode.match(numberformat))
  {
    return true;
  }
  else
  {
    return false;
  }
}



function validateHouseNumber(number)
{
  var numberformat= /^([0-9]){1,3}$/;

  if(number.match(numberformat))
  {
    return true;
  }
  else
  {
    return false;
  }
}



function validateForm()
{
  if($("#nome").val() == "" || !validateName($("#nome").val()))
    {
      var str = " Il nome puo' avere solo caratteri alfabetici";
      $("#nome").focus();
      alert(errore);
      error("nome",str)
      return false;
    }
    else if($("#cognome").val() == "" || !validateName($("#cognome").val()))
    {
      var str = " il cognome puo' avere solo caratteri alfabetici";
      $("#cognome").focus();
      error("cognome",str);
      return false;
    }
    else if($("#email").val() == "" || !ValidateEmail($("#email").val()))
    {
      var str= " Hai inserito un indirizzo email non valido!";
      $("#email").focus();
      error("email",str);
      return false;
    }
   
    else if($("#password").val() == "" || !ValidatePassword($("#password").val()))
    {
      var str = " La pasword deve avere minimo 8 caratteri massimo 16";
      $("#password").focus();
      error("password",str);
      return false;
    }
   
    else if($("#via").val() == "" || !validateName($("#via").val()))
    {
      var str = " Indirizzo non valido";
      $("#via").focus();
      error("via",str);
      return false;
    }
    else if($("#nrCivico").val() == "" || !validateHouseNumber($("#nrCivico").val()))
    {
      var str = " formato numero civico errato";
      $("#nrCivico").focus();
      error("nrCivico",str);


return false;
    }
    else if($("#citta").val() == "" || !validateName($("#citta").val()))
    {
      var str = " formato citta' non valido";
      $("#citta").focus();
      error("citta",str);
      return false;
    }
    else if($("#cap").val() == "" || !validateZipCode($("#cap").val()))
    {
      var str = " formato cap' non valido";
      $("#cap").focus();
      error("cap",str);
      return false;
    }
    else
    {
      cleanError();
      return true;
    }
}