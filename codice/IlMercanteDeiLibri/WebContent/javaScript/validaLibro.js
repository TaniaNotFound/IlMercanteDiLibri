$(document).ready(function(){
         $("#f1").submit(function(){
           return validateForm();
         });
       });
   
  function isEmpty(x)
  {
    if(x.length <= 0)
      return true;
    else
      return false;
  }
  
  function cleanError()
  {
    $('#f1').find( 'input[type!="submit"]' ).each(function () {
        $("span").empty();
    });
  }
    
  function validationTitolo(titolo)
  {
      var text = /^[A-Za-z\s]+$/;
 
      if(!titolo.match(text))
      {
        return false;
      }
      else
        return true;
  }
  function validationAutore(autore)
  {
      var text = /^[A-Za-z\s]+$/;
 
      if(!autore.match(text))
      {
        return false;
      }
      else
        return true;
  }
  function validationEditore(editore)
  {
      var text = /^[A-Za-z\s]+$/;
 
      if(!editore.match(text))
      {
        return false;
      }
      else
        return true;
  }
  function validationEdizione(edizione)
  {
      var text = /^[A-Za-z\s]+$/;
 
      if(!edizione.match(text))
      {
        return false;
      }
      else
        return true;
  }
  function ValidateEmail(email)
  {
     var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
     if(email.match(mailformat))
           return true;
     else
           return false;
  }

 
  function validationPrezzo(prezzo)
  {
    var text = /^[0-9]+[\.,]{1}[0-9]{2}$/;
    
    if(!prezzo.match(text))
      return false;
    else
      return true;
  }
  function validateIsbn(isbn)
  {
    var numberformat= /^([0-9]){1,13}$/;

    if(isbn.match(numberformat))
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
     

    cleanError();
   
    //controllo campo titolo
    if(isEmpty($("#titolo").val()))
    {
        var text = document.createTextNode("Nome obbligatorio!");
        $("#error1").css({"color": "red", "font-size": "100%"});
        $("#error1").append(text);
        $("#titolo").focus();
        return false;
    } 
    
    else if(!validationName($("#titolo").val()))
    {
        var text = document.createTextNode("Solo caratteri alfabetici!");
     $("#error1").css({"color": "red", "font-size": "100%"})
     $("#error1").append(text);
     $("#titolo").focus();
      return false;
    }
     
    
    else if(isEmpty($("isbn").val()))
    {
     var text = document.createTextNode("Categoria obbligatoria!");
     $("#error2").css({"color": "red", "font-size": "100%"});
     $("#error2").append(text);
     $("#isbn").focus();
     return false;
    }
    else if(!validationCategoria($("#isbn").val()))
    {
     var text = document.createTextNode("Spazi non consentiti!");
     $("#error2").css({"color": "red", "font-size": "100%"})
     $("#error2").append(text);
     $("#isbn").focus();
      return false;
    }
    
    //controllo prezzo
    else if(isEmpty($("#prezzo").val()))
    {
     var text = document.createTextNode("Inserire prezzo!");
     $("#error3").css({"color": "red", "font-size": "100%"});
     $("#error3").append(text);
     $("#prezzo").focus();
     return false;
    }
    else if(!validationPrezzo($("#prezzo").val()))
    {
     var text = document.createTextNode("Prezzo inserito non valido!");
     $("#error3").css({"color": "red", "font-size": "100%"});
     $("#error3").append(text);
     $("#prezzo").focus();
     return false;
    }
//controllo campo autore
    if(isEmpty($("#autore").val()))
    {
        var text = document.createTextNode("Nome obbligatorio!");
        $("#error4").css({"color": "red", "font-size": "100%"});
        $("#error4").append(text);
        $("#autore").focus();
        return false;
    } 
    
    else if(!validationName($("#autore").val()))
    {
        var text = document.createTextNode("Solo caratteri alfabetici!");
     $("#error4").css({"color": "red", "font-size": "100%"})
     $("#error4").append(text);
     $("#autore").focus();
      return false;
    }
    
    //controllo campo edizione
    if(isEmpty($("#edizione").val()))
    {
        var text = document.createTextNode("Nome obbligatorio!");
        $("#error5").css({"color": "red", "font-size": "100%"});
        $("#error5").append(text);
        $("#edizione").focus();
        return false;
    } 
    
    else if(!validationName($("#edizione").val()))
    {
        var text = document.createTextNode("Solo caratteri alfabetici!");
     $("#error5").css({"color": "red", "font-size": "100%"})
     $("#error5").append(text);
     $("#edizione").focus();
      return false;
    }
    
    //controllo campo nome editore
    if(isEmpty($("#editore").val()))
    {
        var text = document.createTextNode("Nome obbligatorio!");
        $("#error6").css({"color": "red", "font-size": "100%"});
        $("#error6").append(text);
        $("#editore").focus();
        return false;
    } 
    
    else if(!validationName($("#editore").val()))
    {
        var text = document.createTextNode("Solo caratteri alfabetici!");
     $("#error6").css({"color": "red", "font-size": "100%"})
     $("#error6").append(text);
     $("#editore").focus();
      return false;
    }
    
  }
