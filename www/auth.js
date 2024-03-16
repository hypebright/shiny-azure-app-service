$(document).ready(function () {
    // Wait until Shiny is fully initialized
    $(document).on('shiny:connected', function(event) {
        $.get("https://hangman-shiny.azurewebsites.net/.auth/me", function (data) {
          
          // Extracting the user's name, preferred_username, and user_id
          const name = data[0].user_claims.find(claim => claim.typ === 'name').val;
          const preferredUsername = data[0].user_claims.find(claim => claim.typ === 'preferred_username').val;
          const userId = data[0].user_id;
          
          // Creating an object with extracted data
          const userData = {
              name: name,
              preferred_username: preferredUsername,
              user_id: userId
          };

          Shiny.setInputValue("AzureAuth", userData);
          
      }).fail(function () {
          console.log("Error retrieving user data from Entra ID: defaulting to 'unauthorized'.");
          Shiny.setInputValue("AzureAuth", "unauthorized");
      });
    });
});
